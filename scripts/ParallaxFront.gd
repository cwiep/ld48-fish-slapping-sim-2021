extends ParallaxLayer

export (float) var SPEED = -15

func _process(delta) -> void:
	self.motion_offset.y += SPEED*delta
