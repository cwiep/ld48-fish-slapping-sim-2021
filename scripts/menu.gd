extends Node2D

func _on_play_pressed():
	get_tree().change_scene("res://scenes/main.tscn")


func _on_mouse_controls_toggled(button_pressed):
	Globals.mouse_controls = button_pressed

func _on_mouse_controls_pressed():
	Globals.mouse_controls = !Globals.mouse_controls
	if Globals.mouse_controls:
		$mouse_controls.text = "Right Click"
	else:
		$mouse_controls.text = "WASD"
