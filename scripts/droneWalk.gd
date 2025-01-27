extends CharacterBody2D

var direction
var speed
var grav = -2
var on_edge = false

var chasePlayer = false
var jumping = false
var exploding = false

var explosion = preload("res://scenes/explosion.tscn")

var overlay = {
	"drone" : [preload("res://sprites/game/overlay/Pancake.png"), preload("res://sprites/game/overlay/Basic.png")],
	"transformer" : [preload("res://sprites/game/overlay/SyrupPancake.png"), preload("res://sprites/game/overlay/Mimetic.png")],
	"parasite" : [preload("res://sprites/game/overlay/Pancake.png"), preload("res://sprites/game/overlay/Mimetic.png")],
	"telephony" : [preload("res://sprites/game/overlay/TelePancake.png"), preload("res://sprites/game/overlay/Aerodynamic.png")],
	"IEDrone" : [preload("res://sprites/game/overlay/IEPancake.png"), preload("res://sprites/game/overlay/Basic.png")],
}


func _ready():
	$Overlay.texture = overlay[Global.landingFlavor][0]
	$Overlay/Eye.texture = overlay[Global.landingFlavor][1]
	position = Global.landingPos
	rotation_degrees = 0
	move_and_collide(Vector2(0,11))
	
	if Global.landingFlavor == "parasite":
		scale = Vector2(0.5, 0.5)
	
	if Global.landingFlavor == "IEDrone":
		chasePlayer = true
		$Jump.monitoring = false
		$CanExplode.start()
	
	direction = "right"
	speed = 0.8
	if position.x < 192:
		direction = "left"
		speed = -0.8
		scale.x *= -1
		$Overlay.scale.x *= -1
		$Overlay/Eye.scale.x *= -1

func _process(delta: float) -> void:
	if chasePlayer and speed != 0:
		if position.x > Global.playerPosition.x + 10:
			if direction != "left":
				direction = "left"
				speed = -0.8
				scale.x *= -1
				$Overlay.scale.x *= -1
				$Overlay/Eye.scale.x *= -1
		elif position.x < Global.playerPosition.x - 10:
			if direction != "right":
				direction = "right"
				speed = 0.8
				scale.x *= -1
				$Overlay.scale.x *= -1
				$Overlay/Eye.scale.x *= -1
	
	
	move_and_collide(Vector2(speed,0))
	
	if !is_on_floor() and !jumping and !exploding:
		tiny_jump()
		move_and_collide(Vector2(0,4))
	
	if jumping:
		position += 2 * transform.x
		position.y += grav
		grav += 0.25 
		
		if position.y > 250:
			queue_free()

func tiny_jump():
	if $Raycasts/DetectWall.is_colliding() and $Raycasts/DetectFloor.is_colliding() and $Raycasts/DetectHighWall.is_colliding() == false and $Raycasts/DetectRise.is_colliding() == false:
		move_and_collide(Vector2(0,-4))
		if direction == "right":
			move_and_collide(Vector2(2.25,0))
		else:
			move_and_collide(Vector2(-2.25,0))

func _on_animated_sprite_2d_frame_changed() -> void:
	if on_edge and jumping == false:
		$Overlay.position.y = 0
		$Toes.disabled = true
		jumping = true

func _on_jump_area_entered(area: Area2D) -> void:
	if !jumping:
		speed = 0
		$AnimatedSprite2D.stop()
		on_edge = true
		
		$Overlay.position.y = 2
		$AnimatedSprite2D.play("DroneJump")

func _on_explosion_area_entered(area: Area2D) -> void:
	if !Global.iFrames:
		Audio.play_sound("Hurt")
		Global.iFrames = true
		Global.health -= 32
		Heart.hurt()

func _on_radius_check_area_entered(area: Area2D) -> void:
	speed = 0
	$AnimatedSprite2D.stop()
	
	$Overlay.position.y = 2
	$AnimatedSprite2D.play("DroneJump")
	$AnimatedSprite2D.stop()
	
	$Explode.play("Explode")

func _on_can_explode_timeout() -> void:
	$RadiusCheck.monitoring = true

func explode():
	exploding = true
	Global.landingPos = Vector2(position.x, position.y - 16)
	Global.emit_signal("spawn", explosion)

func disappear():
	$AnimatedSprite2D.modulate.a = 0
	$Overlay.modulate.a = 0

func _on_explode_animation_finished(anim_name: StringName) -> void:
	queue_free()
