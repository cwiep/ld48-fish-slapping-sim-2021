extends Sprite

signal fish_bite(fish)

onready var target_pos = $player.global_position
var speed = 100

func _on_fish_bite(fish):
	emit_signal("fish_bite", fish)

func _physics_process(delta):
	if Input.is_action_pressed("right_click"):
		target_pos = get_global_mouse_position()
	if $player.global_position.distance_to(target_pos) > 5:
		var direction = (target_pos - $player.global_position).normalized()
		$player.move_and_slide(direction * speed)
