extends Node2D

var x1
var x2
var momentum
var headNum = 0

var parasite = preload("res://scenes/parasite.tscn")
var pancakeParticles = preload("res://scenes/pancakeParticles.tscn")
var parachute = preload("res://sprites/game/Parachute.png")
var parachuteFall = preload("res://scenes/parachuteFall.tscn")

var rng = RandomNumberGenerator.new()

@export var flavor = "drone"

func _ready() -> void:
	position.x = Global.planePosition.x
	if Global.planeRotation > 0:
		$Animate.play("swayRight")
	elif Global.planeRotation < 0:
		$Animate.play("swayLeft")
	
	rng.randomize()
	var origin = rng.randf_range(0, 360)
	var origin2 = origin + rng.randf_range(80, 160)
	var origin3 = origin + rng.randf_range(200, 280)
	
	$Drone/Head1.rotation_degrees = origin
	$Drone/Head2.rotation_degrees = origin2
	$Drone/Head3.rotation_degrees = origin3
	
	$Drone/Head1/Crumbs.rotation_degrees -= (origin + rotation_degrees)
	$Drone/Head2/Crumbs.rotation_degrees -= (origin2 + rotation_degrees)
	$Drone/Head3/Crumbs.rotation_degrees -= (origin3+ rotation_degrees)

func _process(_delta):
	#momentum
	if position.y <= 86:
		x1 = position.x
		position.x = Global.planePosition.x
	elif momentum == null:
		momentum = snapped(x2 - x1, 0.1)
	x2 = position.x
	
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

func _on_parachute_fall_area_entered(area: Area2D) -> void:
	Global.landingPos = position
	Global.emit_signal("spawn", parachuteFall)
	queue_free()

func headpop():
	headNum += 1
	if headNum == 1:
		$Drone/Head1.play("PopOut")
		$Drone/Head1/Crumbs/Crumbs1.emitting = true
		$Drone/Head1/Crumbs/Crumbs2.emitting = true
	elif headNum == 2:
		$Drone/Head2.play("PopOut")
		$Drone/Head2/Crumbs/Crumbs1.emitting = true
		$Drone/Head2/Crumbs/Crumbs2.emitting = true
	elif headNum == 3:
		$Drone/Head3.play("PopOut")
		$Drone/Head3/Crumbs/Crumbs1.emitting = true
		$Drone/Head3/Crumbs/Crumbs2.emitting = true
	else:
		$Drone.texture = parachute
		Global.landingPos = position
		Global.emit_signal("spawn", pancakeParticles)
		$Drone/Head1.self_modulate.a = 0
		$Drone/Head2.self_modulate.a = 0
		$Drone/Head3.self_modulate.a = 0
		for x in range(3):
			Global.splittingPos = position
			Global.splitNum = x + 1
			Global.emit_signal("spawn", parasite)
