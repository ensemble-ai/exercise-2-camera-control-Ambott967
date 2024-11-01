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
	
	if ratio:
		if(separation_x > 0):
			position = position.move_toward(Vector3(1, 0, 0), follow_speed * target.BASE_SPEED)
	
	super(delta)

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	
	#!!!!!!!!!!!

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
