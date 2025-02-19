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

	var new_camera = Camera3D.new()
	var camera_script = load("res://source_code/Camera3D.gd")
	new_camera.set_script(camera_script)

	#var camera = track1_instace.get_node("Camera3D")
	var camera_view = lambo.get_node("camera_view")
	new_camera.current = true
	new_camera.target = camera_view
	new_camera.offset = Vector3(0,6,3)
	add_child(new_camera)
