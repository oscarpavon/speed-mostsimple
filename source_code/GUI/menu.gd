extends Control

func _on_play_pressed() -> void:
	$MarginContainer/VBoxContainer/Play/AudioStreamPlayer.play()
	get_tree().change_scene_to_file("res://assets/Scenes/track.tscn")


func _on_quit_pressed() -> void:
	$MarginContainer/VBoxContainer/Play/AudioStreamPlayer.play()
	get_tree().quit()


func _on_settings_pressed() -> void:
	$MarginContainer/VBoxContainer/Play/AudioStreamPlayer.play()
