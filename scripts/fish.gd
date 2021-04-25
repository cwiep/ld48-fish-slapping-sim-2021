extends Area2D

const NUM_FISHES = 4

signal clicked(node)
signal got_player(node)

var _direction = Vector2(0, 0)

var slapped = false
var speed = 200
var health = 1
var type = 0
var player_ref

# public

func slap():
	health -= 1
	if health <= 0:
		slapped = true
		$Sprite.rotation_degrees = -90

# private

func _ready():
	if type == 2:
		# just swim straight
		_direction = (Vector2(1024-global_position.x, global_position.y) - global_position).normalized()
	else:
		_direction = (player_ref.global_position - global_position).normalized()
	if _direction.x > 0:
		$Sprite.flip_h = true
	$Sprite.region_rect.position.x = 64 * type
	$Sprite.self_modulate = Color(randf(), randf(), randf())
	

func _physics_process(delta):
	if slapped:
		position.y -= 300 * delta
		rotate(PI/10)
	else:
		if type == 3: # hunter
			_direction = (player_ref.global_position - global_position).normalized()
		position += _direction * speed * delta

func _on_fish_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("left_click"):
		emit_signal("clicked", self)

func _on_fish_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("got_player", self)
