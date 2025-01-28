extends Node2D

var x1 = 0
var x2 = 0
var momentum
var canJump = false
var side

var stuntDrone2 = preload("res://scenes/stuntDrone2.tscn")

func _ready() -> void:
	hide()
	
	position = Global.planePosition
	side = Global.planeSide
	if side == "Left":
		$Getup.play("Left")
		Global.planeSide = "Right"
	else:
		$Getup.play("Right")
		Global.planeSide = "Left"
	
	if Global.isBlack:
		$Drone.self_modulate = Color8(0,0,0)
		$Drone/Eye.visible = true


func _process(delta: float) -> void:
	x1 = Global.planePosition.x
	momentum = snapped(x2 - x1, 0.1)
	x2 = Global.planePosition.x
	
	if canJump == true:
		if Global.planeRotation > 0 and Global.planePosition.x < 192 and Global.playerPosition.x > Global.planePosition.x:
			$Jump.play("Jump")
			canJump = false
		elif Global.planeRotation < 0 and Global.planePosition.x > 192 and Global.playerPosition.x < Global.planePosition.x:
			$Jump.play("Jump")
			canJump = false
		elif Global.planeRotation == 0:
			$Jump.play("Jump")
			canJump = false

func _on_timer_timeout() -> void:
	canJump = true

func _on_bumper_area_entered(area: Area2D) -> void:
	if canJump:
		$Jump.play("Jump")
		canJump = false

func _on_jump_animation_finished(anim_name: StringName) -> void:
	Global.jumpPos = get_parent().position + position
	Global.jumpRotation = get_parent().rotation_degrees
	Global.jumpMomentum = momentum
	Global.jumpSide = side
	if momentum > 0:
		Global.jumpMomentum += 1
	elif momentum < 0:
		Global.jumpMomentum -= 1
	Global.emit_signal("spawn", stuntDrone2)
	queue_free()
