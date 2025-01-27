extends Node2D

var x1
var x2
var momentum
var time = -1
var particles = false
var explode = false

var rng = RandomNumberGenerator.new()

var explosion = preload("res://scenes/explosion.tscn")
var explosiveChunk = preload("res://scenes/explosiveChunk.tscn")

@export var flavor = "drone"
@export var falling = true

func _ready() -> void:
	position.x = Global.planePosition.x
	if Global.planeRotation > 0:
		$Animate.play("swayRight")
	elif Global.planeRotation < 0:
		$Animate.play("swayLeft")
	
	for x in $Drone/Sparks.get_children():
		x.emitting = true

func _process(_delta):
	#momentum
	if position.y <= 86:
		x1 = position.x
		position.x = Global.planePosition.x
	elif momentum == null:
		momentum = snapped(x2 - x1, 0.1)
	x2 = position.x
	
	if falling:
		position.y += 1.2
	
	if momentum != null:
		position.x += momentum
		settle_momentum()
	
	if position.y >= 300:
		queue_free()

func settle_momentum():
	if momentum != 0:
		if momentum > 0:
			momentum -= 0.1
			if momentum < 0.1:
				momentum = 0
		elif momentum < 0:
			momentum += 0.1
			if momentum > -0.1:
				momentum = 0

func _on_timer_timeout() -> void:
	time += 1
	if time < 3 and time > 0:
		$Drone/Nums.frame = time
	elif time == 3:
		$Drone/Nums.hide()
	elif time == 4:
		for x in $Drone/Sparks.get_children():
			x.emitting = false
		
		Global.landingPos = position
		Global.emit_signal("spawn", explosion)
		explode = true
		$Explode.play("Explode")
		
		rng.randomize()
		Global.splitSeed = rng.randi_range(1, 4)
		Global.chunkDirection = rng.randi_range(1,2)
		for x in range(4):
			Global.splittingPos = position
			Global.splitNum = x
			Global.emit_signal("spawn", explosiveChunk)

func _on_explosion_area_entered(area: Area2D) -> void:
	if !Global.iFrames:
		Audio.play_sound("Hurt")
		Global.iFrames = true
		Global.health -= 32
		Heart.hurt()

func _on_explode_animation_finished(anim_name: StringName) -> void:
	queue_free()
