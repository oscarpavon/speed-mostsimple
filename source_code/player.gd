extends VehicleBody3D

const MAX_STEER = 0.8
@export var engine_power = 300

var velocity_kmh
var sound_db
@export var can_play = false
@export var hub : Control
@export var player = false
@export var camera : Camera3D

func _ready():
	if player == true:
		var camera_view = get_node("camera_view")
		camera.target = camera_view
		hub.player = self
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
	hub.kmh_value = velocity_kmh * 5
	

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
	
