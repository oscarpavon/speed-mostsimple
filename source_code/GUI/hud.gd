extends Node
var can_update_counter = false
@export var player : VehicleBody3D
@export var kmh_value : int
@export var IA : VehicleBody3D
var second = 3
func _ready():
	await get_tree().create_timer(1.0).timeout
	can_update_counter = true
	$Timer.start()

func _process(delta):
	if can_update_counter == true:
		var new_second = int($Timer.time_left)
		if new_second != second:
			second = new_second
			$AudioStreamPlayer.play()
			
		$Label.text = str(new_second+1)
	
	$kmh.text = str(kmh_value) + " KM/h"


func _on_timer_timeout() -> void:
	can_update_counter = false
	$Label.text = "GO"
	$AudioStreamPlayer.pitch_scale = 4
	$AudioStreamPlayer.volume_db += 10
	$AudioStreamPlayer.play()
	IA.do_something = true
	player.can_play = true
	await get_tree().create_timer(1.0).timeout
	$Label.text = ""
	
