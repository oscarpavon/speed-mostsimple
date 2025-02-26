extends Node

var level : Node3D
var player : VehicleBody3D

var HUD : Node

#cars
var lambo_asset = "res://assets/cars/lambo1.tscn"
var lambo2_asset = "res://assets/cars/lambo2.tscn"
var nissan_asset = "res://assets/cars/nissan_gtr.tscn"
var nissan_qashqai_asset = "res://assets/cars/nissan_qashqai.tscn"

#tacks
var track1_asset = "res://assets/Scenes/track.tscn" 
var track2_asset = "res://assets/tracks/track2.tscn" 
var track3_asset = "res://assets/tracks/track3.tscn" 

var current_track = track2_asset

var current_car = nissan_qashqai_asset
#var current_car = lambo2_asset
#var current_car = nissan_asset

var main_camera : Camera3D

var wheel_debug : bool = false

var camera_offset : Vector3 = Vector3(0,3,2)

func _ready():
	#get_tree().change_scene_to_file("res://assets/GUI/menu.tscn")
	load_and_play()
	init_game_type()

func init_game_type():
	pass

func _process(delta):
	if Input.is_action_just_released("debug_wheel"):
		if !wheel_debug:
			wheel_debug = true
		else:
			wheel_debug = false

	if wheel_debug:
		main_camera.offset = Vector3(3,0,0.555)
	else:
		main_camera.offset = camera_offset

	if HUD.player_can_play:
		player.can_play = true


func load_and_play():
	var track = load(current_track)
	level = track.instantiate()
	add_child(level)
	add_player()
	player.player = true
	add_hud()

	var new_camera = Camera3D.new()
	var camera_script = load("res://source_code/Camera3D.gd")
	new_camera.set_script(camera_script)

	#var camera = track1_instace.get_node("Camera3D")
	var camera_view = player.get_node("camera_view")
	new_camera.current = true
	new_camera.target = camera_view
	new_camera.offset = camera_offset
	add_child(new_camera)
	new_camera.name = "main_camera"
	main_camera = new_camera


func add_player():
	var car_asset = load(current_car)
	var player_script = load("res://source_code/player.gd")
	var root_node : Node3D = car_asset.instantiate()
	root_node.name = "player_node"
	player = root_node.get_child(0)
	player.set_script(player_script)
	#player._ready()
	player.name = "player"
	level.add_child(root_node)
	#level.add_child(player)
	var player_start : Node3D = level.get_node("player_start")
	player.transform = player_start.transform

func add_hud():
	var canvas = CanvasLayer.new()
	level.add_child(canvas)
	var hud_asset = load("res://assets/GUI/hud.tscn")
	var hud = hud_asset.instantiate()
	canvas.add_child(hud)
	player.hud = hud
	HUD = hud
	
