extends AnimatedSprite

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	self.connect("animation_finished", self, "_on_mouse_slap_animation_finished")
	self.play("idle")

func _on_mouse_slap_animation_finished():
	self.play("idle")
	
func _process(delta):
	self.global_position = get_global_mouse_position()
