extends KinematicBody2D

onready var target_pos = global_position
var speed = 100

func _physics_process(delta):
	if Input.is_action_pressed("right_click"):
		target_pos = get_global_mouse_position()
	if global_position.distance_to(target_pos) > 5:
		var direction = (target_pos - global_position).normalized()
		look_at(target_pos)
		$worm.play("swim")
		$worm.rotation_degrees = 90
		move_and_slide(direction * speed)
	else:
		rotation_degrees = 0
		$worm.rotation_degrees = 0
		$worm.play("idle")
