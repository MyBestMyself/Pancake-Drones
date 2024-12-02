extends Node2D

var grav = 2
var momentum = Global.jumpMomentum
var rotationDirection
var rotationspeed = 0

var thumper3 = preload("res://scenes/thumper3.tscn")

func _ready():
	position = Global.jumpPos
	show()
	rotation_degrees = Global.jumpRotation
	
	if rotation_degrees < 180:
		rotationDirection = "left"
	elif rotation_degrees > 180:
		rotationDirection = "right"

func _process(delta):
	
	grav += 0.5
	momentum -= 0.025
	position.y += grav
	position.x -= momentum
	
	if rotationDirection == "left":
		if rotation_degrees < 180:
			rotation_degrees += rotationspeed
		else:
			rotation_degrees = 180
	elif rotationDirection == "right":
		if rotation_degrees > 180:
			rotation_degrees -= rotationspeed
		else:
			rotation_degrees = 180
	rotationspeed += 0.25
	
	if position.y > 250:
		queue_free()

func _on_eat_area_entered(area: Area2D) -> void:
	if !Global.iFrames:
		Global.iFrames = true
		Global.health -= 48
		Heart.hurt()


func _on_ground_check_area_entered(area: Area2D) -> void:
	if position.y < 200:
		rotation_degrees = 180
		Global.jumpPos = Vector2(position.x - 41.75 , position.y + 42.87)
		Global.emit_signal("spawn", thumper3)
		queue_free()
