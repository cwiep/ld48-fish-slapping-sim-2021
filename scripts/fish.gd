extends Area2D

const NUM_FISHES = 4
onready var sprite: Sprite = $Sprite

signal clicked(node)

var slapped = false

func _ready():
	sprite.region_rect.position.x = 64 * (randi() % NUM_FISHES)
	sprite.self_modulate = Color(randf(), randf(), randf())

func _process(_delta):
	if position.x < 1024/2:
		$Sprite.flip_h = true

func _on_fish_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("left_click"):
		emit_signal("clicked", self)

func slap():
	slapped = true
	$Sprite.rotation_degrees = -90
