extends Node2D

const SCREEN = Rect2(0, 0, 1024, 600)

onready var fish = preload("res://scenes/fish.tscn")

var chest_animate = false
var wait_for_finish = false

func _ready():
	randomize()
	Globals.reset()
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

func _spawn_fishes(n):
	for _i in range(Globals.difficulty):
		var f = FishGenerator.generate()
		f.connect("clicked", self, "_on_fish_clicked")
		f.connect("got_player", self, "_on_player_hit_by_fish")
		f.player_ref = $player
		$fishes.add_child(f)
		print("spawing fish " + str(f) + " at " + str(f.global_position))

### TIMERS

func _on_spawn_timer_timeout():
	_spawn_fishes(Globals.difficulty)

func _on_finale_timer_timeout():
	print("finale triggered")
	chest_animate = true

func _on_difficulty_timer_timeout():
	Globals.difficulty += 1
	print("difficulty " + str(Globals.difficulty))
	var num_hunters = 2
	if Globals.difficulty == 10:
		chest_animate = true
		num_hunters = 4
		$difficulty_timer.stop()
	for _i in range(num_hunters):
		var f = FishGenerator.generate_hunter()
		f.connect("clicked", self, "_on_fish_clicked")
		f.connect("got_player", self, "_on_player_hit_by_fish")
		f.player_ref = $player
		$fishes.add_child(f)
		print("spawing hunter " + str(f) + " at " + str(f.global_position))
