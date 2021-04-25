extends Node2D

func _on_play_pressed():
	get_tree().change_scene("res://scenes/main.tscn")


func _on_mouse_controls_toggled(button_pressed):
	Globals.mouse_controls = button_pressed
