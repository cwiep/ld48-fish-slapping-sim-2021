extends Area2D

const NUM_FISHES = 4
onready var sprite: Sprite = $Sprite

signal clicked(node)
signal got_player(node)

var slapped = false
var direction = Vector2(0, 0)
var speed = 200

# public

func slap():
	slapped = true
	$Sprite.rotation_degrees = -90

# private

func _ready():
	if direction.x < 0:
		$Sprite.flip_h = true
	sprite.region_rect.position.x = 64 * (randi() % NUM_FISHES)
	sprite.self_modulate = Color(randf(), randf(), randf())

func _physics_process(delta):
	if slapped:
		position.y -= 300 * delta
		rotate(PI/10)
	else:
		position += direction * speed * delta

func _on_fish_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("left_click"):
		emit_signal("clicked", self)

func _on_fish_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("got_player", self)
