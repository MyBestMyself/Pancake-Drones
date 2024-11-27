extends Node2D

var speed
var grounded
var grav
var direction
var rotationspeed = 0
var rng = RandomNumberGenerator.new()

var pancakeFall = preload("res://scenes/droneWalk.tscn")

@export var flavor = "drone"

func _ready() -> void:
	hide()
	rng.randomize()
	position = Global.splittingPos
	
	if Global.splitNum == 1:
		speed = randf_range(-2.5, -2)
	elif Global.splitNum == 2:
		speed = randf_range(-0.5, 0.5)
	elif Global.splitNum == 3:
		speed = randf_range(2, 2.5)
	
	grav = randf_range(-2, -1)
	rotation_degrees = speed * 25
	
	if speed > 0:
		direction = "right"
	elif speed < 0:
		direction = "left"

func _process(_delta):
	show()
	
	position.x += speed
	position.y += grav
	if grav < 5:
		grav += 0.2
	
	if speed > 0 and direction == "right":
		speed -= 0.025
	elif speed < 0 and direction == "left":
		speed += 0.025
	
	if rotation_degrees > 0 and direction == "right":
		rotationspeed += 1
		rotation_degrees -= rotationspeed
	elif rotation_degrees < 0 and direction == "left":
		rotationspeed += 1
		rotation_degrees += rotationspeed
	
	if position.y > 250:
		queue_free()

func _on_eat_area_entered(area: Area2D) -> void:
	if !Global.iFrames:
		Global.iFrames = true
		Global.health -= 16
		Heart.hurt()

func _on_ground_check_area_entered(area: Area2D) -> void:
	Global.landingPos = position
	Global.landingFlavor = flavor
	Global.emit_signal("spawn", pancakeFall)
	queue_free()
