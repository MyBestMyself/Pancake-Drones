extends Node2D

var direction
var grav = -3
var velocity = Global.jumpMomentum
var rotspeed = 5
var grounded = false
var side = Global.jumpSide

func _ready():
	position = Global.jumpPos
	rotation_degrees = Global.jumpRotation
	
	if rotation_degrees > 0:
		direction = "Left"
	elif rotation_degrees < 0:
		direction = "Right"
	elif rotation_degrees == 0 and side == "Right":
		direction = "Left"
	elif rotation_degrees == 0 and side == "Left":
		direction = "Right"

func _process(delta: float) -> void:
	if direction == "Left": #and rotation_degrees < 180:
		rotation_degrees += rotspeed
	elif direction == "Right": #and rotation_degrees > -180:
		rotation_degrees -= rotspeed
	
	position.x -= velocity
	position.y += grav
	
	if velocity > 0:
		velocity -= 0.025
	if rotspeed > 0.1:
		rotspeed -= 0.05
	if grav < 6 and !grounded:
		grav += 0.3 
	elif grounded:
		grav += 0.3
	
	if position.y > 250:
		queue_free()

func _on_eat_area_entered(area: Area2D) -> void:
	if !Global.iFrames:
		Audio.play_sound("Hurt")
		Global.iFrames = true
		Global.health -= 32
		Heart.hurt()

func _on_ground_check_area_entered(area: Area2D) -> void:
	if grounded == false:
		grounded = true
		$Eat.monitoring = false
		grav = -3
		rotspeed = 10
