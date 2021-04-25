extends KinematicBody2D

onready var target_pos = global_position
var speed = 130

func _physics_process(delta):
	if Globals.mouse_controls:
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
	else:
		var direction = Vector2(0, 0)
		if Input.is_action_pressed("player_up"):
			direction.y = -1
		elif Input.is_action_pressed("player_down"):
			direction.y = 1
		if Input.is_action_pressed("player_left"):
			direction.x = -1
		elif Input.is_action_pressed("player_right"):
			direction.x = 1
			
		if direction.x != 0 or direction.y != 0:
			direction = direction.normalized()
			$worm.play("swim")
			$worm.rotation_degrees = 90
			look_at(global_position + direction)
			move_and_slide(direction * speed)
		else:
			rotation_degrees = 0
			$worm.rotation_degrees = 0
			$worm.play("idle")
	
	
	
