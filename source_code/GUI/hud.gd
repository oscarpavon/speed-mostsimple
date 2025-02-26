extends Node
var can_update_counter = false
@export var kmh_value : int
var second = 3

var player_can_play : bool = false

var total_time_game_trial : int = 0

func _ready():

	var game_type = Global.game_type
	var time_trial_label : Label = get_node("time_trial_counter")
	if game_type == Global.TIME_TRIAL:
		time_trial_label.visible = true
		start_init_counter()
	else:
		time_trial_label.visible = false


func _process(delta):
	if can_update_counter == true:
		var new_second = int($Timer.time_left)
		if new_second != second:
			second = new_second
			$AudioStreamPlayer.play()
			
		$Label.text = str(new_second+1)
	
	$kmh.text = str(kmh_value) + " KM/h"


func start_init_counter():
	await get_tree().create_timer(1.0).timeout
	can_update_counter = true
	$Timer.start()

func start_time_trial_counter():
	var timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_timer_game_trial_timeout)
	timer.start()


func handle_game_mode():
	if Global.game_type == Global.TIME_TRIAL:
		start_time_trial_counter()


func _on_timer_game_trial_timeout():
	total_time_game_trial += 1
	var minute = int(total_time_game_trial / 60.0)
	var seconds = total_time_game_trial - minute * 60
	$time_trial_counter.text = '%02d:%02d' % [minute, seconds]

	


func _on_timer_timeout() -> void:
	can_update_counter = false
	$Label.text = "GO"
	$AudioStreamPlayer.pitch_scale = 4
	$AudioStreamPlayer.volume_db += 10
	$AudioStreamPlayer.play()
	player_can_play = true
	handle_game_mode()
	await get_tree().create_timer(1.0).timeout
	$Label.text = ""
	
