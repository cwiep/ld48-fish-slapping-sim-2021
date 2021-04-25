extends Node2D

const SCREEN = Rect2(0, 0, 1024, 600)

onready var fish = preload("res://scenes/fish.tscn")

var difficulty = 2
var chest_animate = false
var wait_for_finish = false

func _ready():
	randomize()
	print("\nstarting game")

func _process(delta):
	for f in $fishes.get_children():
		if not SCREEN.has_point(f.global_position):
			print("removing " + str(f) + " at " + str(f.global_position))
			$fishes.remove_child(f)
			continue
	if chest_animate:
		$ground.position.y -= 100 * delta
		if $ground.position.y <= 0:
			$ground.position.y = 0
			chest_animate = false
			$background/front.SPEED = -50
			$background/back.SPEED = -20
			$spawn_timer.stop()
			$ground/chest.region_rect.position.x = 128
			wait_for_finish = true
	if wait_for_finish and $fishes.get_child_count() == 0:
		get_tree().change_scene("res://scenes/ending.tscn")
	

func _get_random_spawn() -> Vector2:
	var x = [1, SCREEN.size.x-64][randi() % 2]
	var y = 1 + randi() % (1024 - 64)
	return Vector2(x, y)

func _on_fish_clicked(node):
	if node.slapped:
		return
	print("slapped" + str(node))
	Globals.points += 1
	$slap_audio.pitch_scale = 0.75 + randf() * 0.5
	$slap_audio.play()
	$mouse.play("slap")
	node.slap()

func _on_player_hit_by_fish(some_fish):
	if some_fish.slapped:
		return
	print("entered: " + str(some_fish))
	print("slaps: " + str(Globals.points))
	get_tree().change_scene("res://scenes/game_over.tscn")

### TIMERS

func _on_spawn_timer_timeout():
	for _i in range(difficulty):
		var f = fish.instance()
		f.position = _get_random_spawn()
		print("spawing fish " + str(f) + " at " + str(f.position))
		f.connect("clicked", self, "_on_fish_clicked")
		f.connect("got_player", self, "_on_player_hit_by_fish")
		f.direction = ($player.global_position - f.position).normalized()
		$fishes.add_child(f)
	difficulty += 1

func _on_finale_timer_timeout():
	print("finale triggered")
	chest_animate = true
	
