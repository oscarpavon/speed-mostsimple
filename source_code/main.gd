extends Node

var track1
func _ready():
	#get_tree().change_scene_to_file("res://assets/GUI/menu.tscn")
	#get_tree().change_scene_to_file("res://assets/Scenes/track.tscn")
	load_and_play()


func load_and_play():
	track1 = load("res://assets/Scenes/track.tscn")
	var track1_instace = track1.instantiate()
	add_child(track1_instace)
	var hud = track1_instace.get_node("CanvasLayer/HUD")
	var lambo = track1_instace.get_node("lambo1")
	hud.player = lambo
	lambo.player = true
	var camera = track1_instace.get_node("Camera3D")
	var camera_view = lambo.get_node("camera_view")
	camera.target = camera_view



