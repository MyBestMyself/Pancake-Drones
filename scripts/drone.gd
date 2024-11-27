extends Node2D

var x1
var x2
var momentum

var parachute = preload("res://sprites/game/Parachute.png")
var pancakeFall = preload("res://scenes/droneWalk.tscn")
var parachuteFall = preload("res://scenes/parachuteFall.tscn")

@export var flavor = "drone"

func _ready() -> void:
	position.x = Global.planePosition.x
	if Global.planeRotation > 0:
		$Animate.play("swayRight")
	elif Global.planeRotation < 0:
		$Animate.play("swayLeft")

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

func _on_pancake_fall_area_entered(area: Area2D) -> void:
	$Drone/PancakeFall.queue_free()
	Global.landingPos = position
	Global.landingFlavor = flavor
	Global.emit_signal("spawn", pancakeFall)
	
	position.y -= 12.5
	$Drone.texture = parachute


func _on_eat_area_entered(area: Area2D) -> void:
	if !Global.iFrames:
		Global.iFrames = true
		Global.health -= 32
		Heart.hurt()
