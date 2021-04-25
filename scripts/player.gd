extends KinematicBody2D

onready var target_pos = global_position
var speed = 100

func _physics_process(delta):
	if Input.is_action_pressed("right_click"):
		target_pos = get_global_mouse_position()
	if global_position.distance_to(target_pos) > 5:
		var direction = (target_pos - global_position).normalized()
		move_and_slide(direction * speed)
