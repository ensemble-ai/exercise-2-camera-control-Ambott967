class_name Stage3Camera
extends CameraControllerBase


@export var follow_speed: float = 0.8
@export var catchup_speed: float = 30
@export var leash_distance: float = 7


var ratio: bool


func _ready() -> void:
	super()
	position = target.position
	if(follow_speed > 1):
		ratio = false
	else:
		ratio = true


func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	
	var separation_x = target.global_position.x - global_position.x
	var separation_z = target.global_position.z - global_position.z
	
	if target.velocity.is_equal_approx(Vector3(0, 0, 0)):
		position = position.move_toward(Vector3(target.position.x, position.y, target.position.z), delta * catchup_speed)
	
	if ratio:
		position = position.move_toward(Vector3(target.position.x, position.y, target.position.z), delta * follow_speed * target.BASE_SPEED)
	elif !ratio:
		position = position.move_toward(Vector3(target.position.x, position.y, target.position.z), delta * follow_speed)
	
	var right_leash = target.position.x - position.x - leash_distance
	if right_leash > 0:
		position.x += right_leash
	var bottom_leash = target.position.z - position.z - leash_distance
	if bottom_leash > 0:
		position.z += bottom_leash
	var left_leash = target.position.x - position.x + leash_distance
	if left_leash < 0:
		position.x += left_leash
	var top_leash = target.position.z - position.z + leash_distance
	if top_leash < 0:
		position.z += top_leash
	
	super(delta)

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	#left
	immediate_mesh.surface_add_vertex(Vector3(-5, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 0))
	#up
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -5))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 0))
	#right
	immediate_mesh.surface_add_vertex(Vector3(5, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 0))
	#down
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 5))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 0))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
