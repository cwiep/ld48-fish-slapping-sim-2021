extends Area2D

signal collected(pearl)

func _physics_process(delta):
	position.y += 100 * delta

func _on_pearl_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("collected", self)
