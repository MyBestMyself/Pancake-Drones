extends CharacterBody2D

var x1
var x2
var momentum
var flying = false
var grounded = false

var pancakeFall = preload("res://scenes/droneWalk.tscn")

@export var flavor = "drone"
@export var speed : float = 2.5

func _ready() -> void:
	position.x = Global.planePosition.x

func _process(_delta):
	#momentum
	if flying == false:
		if position.y <= 86:
			x1 = position.x
			position.x = Global.planePosition.x
		elif momentum == null:
			momentum = snapped(x2 - x1, 0.1)
	x2 = position.x
	
	if grounded:
		move_and_collide(Vector2(0,4))
	else:
		position -= speed * transform.y
	
	if momentum != null:
		position.x += momentum
		settle_momentum()
	
	if momentum == 0 and !flying:
		flying = true
		if position.x < 192:
			$Animate.play("CurveRight")
		else:
			$Animate.play("CurveLeft")
	
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

func _on_pancake_fall_area_entered(area: Area2D) -> void:
	$Drone/PancakeFall.queue_free()
	grounded = true
	$Drone.play("No")
	$Animate.play("Fade")
	for x in $Particles.get_children():
		x.emitting = true
	
	Global.cameraShakeTiny.emit()


func _on_eat_area_entered(area: Area2D) -> void:
	if !Global.iFrames:
		Global.iFrames = true
		Global.health -= 32
		Heart.hurt()

func kill():
	queue_free()
