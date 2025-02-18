extends Node3D

@export var car1 : VehicleBody3D
@export var car2 : VehicleBody3D
@export var hud : Control
@export var camera : Camera3D


func _ready():
	car1.player = true
	car2.player = false
	hud.player = car1
	var camera_view = car1.get_node_or_null("camera_view")
	if camera_view == null:
		return
	camera.target = camera_view



