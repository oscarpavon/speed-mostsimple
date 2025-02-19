extends Node

var track1
var level : Node3D
var player : VehicleBody3D
func _ready():
	#get_tree().change_scene_to_file("res://assets/GUI/menu.tscn")
	#get_tree().change_scene_to_file("res://assets/Scenes/track.tscn")
	load_and_play()


func load_and_play():
	track1 = load("res://assets/Scenes/track.tscn")
	level = track1.instantiate()
	add_child(level)
	player = level.get_node("lambo1")
	player.player = true
	add_hud()

	var new_camera = Camera3D.new()
	var camera_script = load("res://source_code/Camera3D.gd")
	new_camera.set_script(camera_script)

	#var camera = track1_instace.get_node("Camera3D")
	var camera_view = player.get_node("camera_view")
	new_camera.current = true
	new_camera.target = camera_view
	new_camera.offset = Vector3(0,6,3)
	add_child(new_camera)

func add_hud():
	var canvas = CanvasLayer.new()
	level.add_child(canvas)
	var hud_asset = load("res://assets/GUI/hud.tscn")
	var hud = hud_asset.instantiate()
	canvas.add_child(hud)
	var ia = level.get_node("IA")
	hud.player = player
	hud.IA = ia
	player.hud = hud
