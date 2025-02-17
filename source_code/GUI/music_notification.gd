extends Button

var one_time = false
func _ready():
	self.hide()
	
func _process(delta):
	if one_time == false:
		await get_tree().create_timer(1.0).timeout
		self.show()
		await get_tree().create_timer(2.0).timeout
		self.hide()
		one_time = true
