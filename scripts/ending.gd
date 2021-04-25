extends Node2D

enum {MOVE_DOWN, PULL_UP, STAY}

var state = MOVE_DOWN

func _ready():
	print("ending started, points: " + str(Globals.points))
	$ground/chest.region_rect.position.x = 128
	$background/back.SPEED = -20
	$background/front.SPEED = -50

func _process(delta):
	if state == MOVE_DOWN:
		$hook.position.y += delta * 100
		if $hook.position.y + $hook.get_rect().size.y/2 >= 500:
			state = PULL_UP
			print(state)
	elif state == PULL_UP:
		$hook.position.y -= delta * 100
		$ground/chest.position.y -= delta * 100
		if $ground/chest.position.y + $ground/chest.get_rect().size.y <= 0:
			state = STAY
			$points.text = str(Globals.points) + " Points"
			$points.show()
			print(state)
