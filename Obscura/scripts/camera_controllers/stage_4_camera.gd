class_name Stage4Camera
extends CameraControllerBase


@export var lead_speed: float = 150
@export var catchup_delay_duration: float = 2
@export var catchup_speed: float = 150
@export var leash_distance: float = 7


@onready var delay_timer: Timer = $DelayTimer

var is_cooling_down: bool = false
var signal_active: bool = false

func _ready() -> void:
	super()
	position = target.position


func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	if target.velocity.is_equal_approx(Vector3(0, 0, 0)) and !is_cooling_down:
		is_cooling_down = true
		$DelayTimer.start(catchup_delay_duration)
	
	if signal_active and target.velocity.is_equal_approx(Vector3(0, 0, 0)):
		position = position.move_toward(Vector3(target.position.x, position.y, target.position.z), delta * catchup_speed)
	
	if position.x == target.position.x and position.z == target.position.z:
		signal_active = false
	
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


func _on_delay_timer_timeout() -> void:
	is_cooling_down = false
	signal_active = true
