extends Node2D

var x1
var x2
var momentum
var teleports = 2
var falling = true

var rng = RandomNumberGenerator.new()

var teleportParticles = preload("res://scenes/teleportParticles.tscn")
var parachute = preload("res://sprites/game/Parachute.png")
var pancakeFall = preload("res://scenes/droneWalk.tscn")
var parachuteFall = preload("res://scenes/parachuteFall.tscn")

@export var flavor = "telephony"

func _ready() -> void:
	position.x = Global.planePosition.x
	if Global.planeRotation > 0:
		$Animate.play("swayRight")
	elif Global.planeRotation < 0:
		$Animate.play("swayLeft")
	
	if Global.isBlack:
		$Drone.play("TriangulateDark")
	else:
		$Drone.play("Triangulate")

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

func _on_teleport_check_area_entered(area: Area2D) -> void:
	if teleports >= 0:
		rng.randomize()
		$Animate.pause()
		$Drone.self_modulate.a = 0
		falling = false
		
		teleport_effect()
		
		position = Vector2(rng.randi_range(80,304), 110)
		
		$Pause1.start()

func teleport_effect():
	Global.landingPos = Vector2(position.x, position.y) 
	Global.landingRot = $Drone.rotation_degrees
	Global.teleportsLeft = teleports
	Global.emit_signal("spawn", teleportParticles)

func _on_pause_1_timeout() -> void:
	teleport_effect()
	$Pause2.start()

func _on_pause_2_timeout() -> void:
	$Animate.play()
	teleports -= 1
	momentum = 0
	falling = true
	$Fade.play("FadeIn")
	
	if teleports >= 0:
		$Drone/TeleportCheck/CollisionShape2D.disabled = false
	else:
		$Drone/PancakeFall/CollisionShape2D.disabled = false
		$Drone/ParachuteFall/CollisionShape2D.disabled = false

func _on_parachute_fall_area_entered(area: Area2D) -> void:
	Global.landingPos = position
	Global.emit_signal("spawn", parachuteFall)
	queue_free()

func _on_pancake_fall_area_entered(area: Area2D) -> void:
	$Drone/PancakeFall.queue_free()
	Global.landingPos = position
	Global.landingFlavor = flavor
	Global.emit_signal("spawn", pancakeFall)
	
	position.y -= 12.5
	$Drone.play("Parachute")

func _on_eat_area_entered(area: Area2D) -> void:
	if !Global.iFrames:
		Global.iFrames = true
		Global.health -= 32
		Heart.hurt()
