extends Node

onready var simple_fish = preload("res://scenes/fish.tscn")
onready var hunter_fish = preload("res://scenes/hunter_fish.tscn")

func generate():
	var f = simple_fish.instance()
	f.type = randi() % 3
	if f.type == 0:
		f.speed = 100
	elif f.type == 1:
		f.speed = 150
	elif f.type == 2:
		f.speed = 200
	f.position = _get_random_spawn()
	return f
	
func generate_hunter():
	var f = simple_fish.instance()
	f.type = 3
	f.speed = 150
	f.position = _get_random_spawn()
	return f
	
func _get_random_spawn() -> Vector2:
	var x = [1, get_viewport().get_visible_rect().size.x-64][randi() % 2]
	var y = 1 + randi() % (1024 - 64)
	return Vector2(x, y)
