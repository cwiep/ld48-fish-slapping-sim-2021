extends Node2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$bite_sound.play()
	var date = OS.get_date();
	$game_over_message.text = "RIP Walter Wormington\n2021 - " + str(date["year"]) + "\nHe dove deep and collected " + str(Globals.points) + " points but never came up again."

func _process(delta):
	if $hook.position.y + $hook.get_rect().size.y > 0:
		$hook.position.y -= 200 * delta

func _on_play_again_pressed():
	get_tree().change_scene("res://scenes/main.tscn")
