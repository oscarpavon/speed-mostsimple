extends VehicleBody3D

const MAX_STEER = 0.8
@export var engine_power = 4000

var velocity_kmh

var sound_pitch

@export var can_play = false
@export var hud : Control
@export var player = false

var wheel_rest : float = 0.005

func _ready():
	var camera_view : Node3D = Node3D.new()
	camera_view.name = "camera_view"
	add_child(camera_view)
	camera_view.rotation.x = deg_to_rad(-90)
	camera_view.translate(Vector3(0,1,0))

	var engine_audio : AudioStreamPlayer = AudioStreamPlayer.new()
	engine_audio.stream = load("res://assets/audio/engine2.mp3")
	add_child(engine_audio)
	engine_audio.name = "engine_audio"

	init_car()
	if player == true:
		hud.player = self

func init_car():
	#center_of_mass_mode = RigidBody3D.CENTER_OF_MASS_MODE_CUSTOM
	#center_of_mass = Vector3(0,0,1.19)
	mass = 1500

	set_front_wheel($front_right)
	set_front_wheel($front_left)
	set_back_wheel($back_right)
	set_back_wheel($back_left)

	# set_same_wheel_config($front_left)
	# set_same_wheel_config($front_right)
	# set_same_wheel_config($back_right)
	# set_same_wheel_config($back_left)


func set_same_wheel_config(wheel : VehicleWheel3D):
	wheel.suspension_travel = 0.2
	wheel.suspension_stiffness = 100
	wheel.wheel_rest_length = 0.025
	wheel.wheel_friction_slip = 10
	wheel.wheel_roll_influence = 0.2


func set_front_wheel(wheel : VehicleWheel3D):
	wheel.use_as_steering = true
	wheel.suspension_travel = 0.1
	wheel.suspension_stiffness = 120.0
	wheel.wheel_rest_length = wheel_rest
	wheel.wheel_friction_slip = 10.5
	wheel.wheel_roll_influence = 1

func set_back_wheel(wheel : VehicleWheel3D):
	wheel.use_as_traction = true
	wheel.suspension_travel = 0.1
	wheel.suspension_stiffness = 120
	wheel.wheel_rest_length = wheel_rest
	wheel.wheel_friction_slip = 8
	wheel.wheel_roll_influence = 1
	

	


func _process(delta):
	if player == false:
		pass
	if(can_play == true):
		play(delta)
	play_engine_sound()
	
func play(delta):
	steering = move_toward(steering,Input.get_axis("steer_right", "steer_left") * MAX_STEER,  delta * 2.5)
	engine_force = Input.get_axis("brake", "accelerate") * engine_power 
	velocity_kmh = self.linear_velocity.length()
	hud.kmh_value = velocity_kmh * 5
	

func play_engine_sound():
	
	if !$engine_audio.playing:
		$engine_audio.play()
	if can_play == true:
		sound_pitch = velocity_kmh / 6
		if velocity_kmh > 0.1:
			$engine_audio.pitch_scale = sound_pitch


func _on_body_entered(body: Node) -> void:
	if can_play && player:
		if(velocity_kmh > 5):
			if body.name == "road_collision":
				$Crash.play()
	
