extends VehicleBody3D

const MAX_STEER = 0.8
@export var engine_power = 300

var velocity_kmh
var sound_db
@export var can_play = false
@export var hud : Control
@export var player = false

func _ready():
	var camera_view : Node3D = Node3D.new()
	camera_view.name = "camera_view"
	add_child(camera_view)
	camera_view.rotation.x = deg_to_rad(-90)

	init_car()
	if player == true:
		hud.player = self

func init_car():
	#center_of_mass_mode = RigidBody3D.CENTER_OF_MASS_MODE_CUSTOM
	#center_of_mass = Vector3(0,0,1.19)

	set_front_wheel($front_right)
	set_front_wheel($front_left)
	set_back_wheel($back_right)
	set_back_wheel($back_left)



func set_front_wheel(wheel : VehicleWheel3D):
	wheel.use_as_steering = true
	wheel.suspension_travel = 0.2
	wheel.suspension_stiffness = 120.0
	wheel.wheel_rest_length = 0.15
	wheel.wheel_friction_slip = 10.5

func set_back_wheel(wheel : VehicleWheel3D):
	wheel.use_as_traction = true
	wheel.wheel_roll_influence = 0.01
	wheel.wheel_rest_length = 0.2
	wheel.wheel_friction_slip = 1.1
	wheel.suspension_travel = 0.15
	wheel.suspension_stiffness = 80.0
	

	


func _process(delta):
	if player == false:
		pass
	if(can_play == true):
		play(delta)
	#play_engine_sound()
	
func play(delta):
	steering = move_toward(steering,Input.get_axis("steer_right", "steer_left") * MAX_STEER,  delta * 2.5)
	engine_force = Input.get_axis("brake", "accelerate") * engine_power 
	velocity_kmh = self.linear_velocity.length()
	hud.kmh_value = velocity_kmh * 5
	

func play_engine_sound():
	
	if !$Engine.playing:
		$Engine.play()
	if can_play == true:
		sound_db = velocity_kmh / 4
		if velocity_kmh > 0.1:
			$Engine.pitch_scale = sound_db


func _on_body_entered(body: Node) -> void:
	if can_play && player:
		if(velocity_kmh > 5):
			if body.name == "road_collision":
				$Crash.play()
	
