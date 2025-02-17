extends VehicleBody3D

@export var do_something = false

const ENGINE_POWER = 300

func _process(delta):
	if do_something:
		engine_force = 1 * ENGINE_POWER


