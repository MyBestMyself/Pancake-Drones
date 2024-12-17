extends Node2D

var open = false
var rng = RandomNumberGenerator.new()
var num = 0
var wall1 = 0
var wall2 = 0
var moving = false
var walls = [1,2,3,4]

func _ready():
	rng.randomize()
	
	num = rng.randi_range(0, walls.size() - 1)
	wall1 = walls[num]
	walls.remove_at(num)
	num = rng.randi_range(0, walls.size() - 1)
	wall2 = walls[num]
	walls.remove_at(num)
	
	if Global.mazeSetup:
		spring_walls()
		spring_walls2()
	
	if walls.size() == 0:
		walls = [1,2,3,4]

func _process(delta):
	if Global.mazeCanShift:
		Global.mazeCanShift = false
		move_walls()
		move_walls2()
		$InitialSpring.stop()
		$Spring.start()
	
	if Global.points > 49 and !open:
		open = true
		if Global.walkDirection == "Right":
			$EndPillarLeft/Animate.play("Popup")
		else:
			$EndPillarRight/Animate.play("Popup")

func _on_initial_spring_timeout() -> void:
	spring_walls()
	spring_walls2()

func _on_spring_timeout() -> void:
	rng.randomize()
	
	num = rng.randi_range(0, walls.size() - 1)
	wall1 = walls[num]
	walls.remove_at(num)
	
	num = rng.randi_range(0, walls.size() - 1)
	wall2 = walls[num]
	walls.remove_at(num)
	
	spring_walls()
	spring_walls2()
	
	if walls.size() == 0:
		walls = [1,2,3,4]

func move_walls():
	match wall1:
		1:
			if $Pillar1.position.y > 0:
				$Pillar1/Animate.play("MoveUp")
				$FGPillar2/Animate.play("MoveUp")
			else:
				$Pillar1/Animate.play("MoveDown")
				$FGPillar2/Animate.play("MoveDown")
		2:
			if $Pillar2.position.y > 0:
				$Pillar2/Animate.play("MoveUp")
			else:
				$Pillar2/Animate.play("MoveDown")
		3:
			if $Pillar3.position.y > 0:
				$Pillar3/Animate.play("MoveUp")
			else:
				$Pillar3/Animate.play("MoveDown")
		4:
			if $Pillar4.position.y > 0:
				$Pillar4/Animate.play("MoveUp")
				$FGPillar/Animate.play("MoveUp")
			else:
				$Pillar4/Animate.play("MoveDown")
				$FGPillar/Animate.play("MoveDown")

func move_walls2():
	match wall2:
		1:
			if $Pillar1.position.y > 0:
				$Pillar1/Animate.play("MoveUp")
				$FGPillar2/Animate.play("MoveUp")
			else:
				$Pillar1/Animate.play("MoveDown")
				$FGPillar2/Animate.play("MoveDown")
		2:
			if $Pillar2.position.y > 0:
				$Pillar2/Animate.play("MoveUp")
			else:
				$Pillar2/Animate.play("MoveDown")
		3:
			if $Pillar3.position.y > 0:
				$Pillar3/Animate.play("MoveUp")
			else:
				$Pillar3/Animate.play("MoveDown")
		4:
			if $Pillar4.position.y > 0:
				$Pillar4/Animate.play("MoveUp")
				$FGPillar/Animate.play("MoveUp")
			else:
				$Pillar4/Animate.play("MoveDown")
				$FGPillar/Animate.play("MoveDown")

func spring_walls():
	match wall1:
		1:
			if $Pillar1.position.y > 0:
				$Pillar1/Animate.play("SpringDown")
				$FGPillar2/Animate.play("SpringDown")
			else:
				$Pillar1/Animate.play("SpringUp")
				$FGPillar2/Animate.play("SpringUp")
		2:
			if $Pillar2.position.y > 0:
				$Pillar2/Animate.play("SpringDown")
			else:
				$Pillar2/Animate.play("SpringUp")
		3:
			if $Pillar3.position.y > 0:
				$Pillar3/Animate.play("SpringDown")
			else:
				$Pillar3/Animate.play("SpringUp")
		4:
			if $Pillar4.position.y > 0:
				$Pillar4/Animate.play("SpringDown")
				$FGPillar/Animate.play("SpringDown")
			else:
				$Pillar4/Animate.play("SpringUp")
				$FGPillar/Animate.play("SpringUp")

func spring_walls2():
	match wall2:
		1:
			if $Pillar1.position.y > 0:
				$Pillar1/Animate.play("SpringDown")
				$FGPillar2/Animate.play("SpringDown")
			else:
				$Pillar1/Animate.play("SpringUp")
				$FGPillar2/Animate.play("SpringUp")
		2:
			if $Pillar2.position.y > 0:
				$Pillar2/Animate.play("SpringDown")
			else:
				$Pillar2/Animate.play("SpringUp")
		3:
			if $Pillar3.position.y > 0:
				$Pillar3/Animate.play("SpringDown")
			else:
				$Pillar3/Animate.play("SpringUp")
		4:
			if $Pillar4.position.y > 0:
				$Pillar4/Animate.play("SpringDown")
				$FGPillar/Animate.play("SpringDown")
			else:
				$Pillar4/Animate.play("SpringUp")
				$FGPillar/Animate.play("SpringUp")
