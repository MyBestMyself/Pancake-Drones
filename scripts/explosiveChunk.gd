extends CharacterBody2D

var speed
var grounded
var grav
var direction
var rng = RandomNumberGenerator.new()
var num

var tinyExplosion = preload("res://scenes/tinyExplosion.tscn")

func _ready():
	hide()
	rng.randomize()
	position = Global.splittingPos
	num = Global.splitNum
	for x in Global.splitSeed + num:
		$AnimatedSprite.frame = ($AnimatedSprite.frame + 1) % 4
	
	if num == 0:
		grav = -4 
		if Global.chunkDirection == 1:
			speed = rng.randi_range(-3, -1)
		else:
			speed = rng.randi_range(1, 3)
	elif num == 1:
		grav = -3 
		if Global.chunkDirection == 2:
			speed = rng.randi_range(-3, -1)
		else:
			speed = rng.randi_range(1, 3)
	elif num == 2:
		grav = -2
		if Global.chunkDirection == 1:
			speed = rng.randi_range(-3, -1)
		else:
			speed = rng.randi_range(1, 3)
	elif num == 3:
		grav = -1
		if Global.chunkDirection == 2:
			speed = rng.randi_range(-3, -1)
		else:
			speed = rng.randi_range(1, 3)
	
	rotation_degrees = speed * 25
	
	if speed > 0:
		direction = "right"
	elif speed < 0:
		direction = "left"
	
	if $AnimatedSprite.frame == 0:
		$Sparks/Sparks0.emitting = true
	elif $AnimatedSprite.frame == 1:
		$Sparks/Sparks1.emitting = true
	elif $AnimatedSprite.frame == 2:
		$Sparks/Sparks2.emitting = true
	elif $AnimatedSprite.frame == 3:
		$Sparks/Sparks3.emitting = true
	
	$Timer.wait_time = 0.5 + (num * 0.1)
	$Timer.start()
	show()

func _process(delta):
	
	if !is_on_floor():
		move_and_collide(Vector2(speed,grav))
		grav += 0.2
		
		if speed > 0 and direction == "right" and position.y < 175:
			speed -= 0.025
			rotation_degrees += 2
		elif speed < 0 and direction == "left" and position.y < 175:
			speed += 0.025
			rotation_degrees -= 2
	
	if position.y >= 175 and num != 3:
		Global.landingPos = position
		Global.emit_signal("spawn", tinyExplosion)
		queue_free()


func _on_timer_timeout() -> void:
	Global.landingPos = position
	Global.emit_signal("spawn", tinyExplosion)
	queue_free()
