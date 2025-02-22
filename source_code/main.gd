extends Node

var level : Node3D
var player : VehicleBody3D


#cars
var lambo_asset = "res://assets/cars/lambo1.tscn"
var nissan_asset = "res://assets/cars/nissan_gtr.tscn"

#tacks
var track1_asset = "res://assets/Scenes/track.tscn" 
var track2_asset = "res://assets/tracks/track2.tscn" 
var track3_asset = "res://assets/tracks/track3.tscn" 

var current_track = track2_asset

var current_car = lambo_asset

func _ready():
	#get_tree().change_scene_to_file("res://assets/GUI/menu.tscn")
	load_and_play()


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
	new_camera.offset = Vector3(0,6,3)
	add_child(new_camera)


func add_player():
	var car_asset = load(current_car)
	var player_script = load("res://source_code/player.gd")
	player = car_asset.instantiate()
	player.set_script(player_script)
	level.add_child(player)
	var player_start : Node3D = level.get_node("player_start")
	player.transform = player_start.transform

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
