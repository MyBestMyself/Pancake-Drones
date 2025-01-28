extends CharacterBody2D

var x1
var x2
var momentum = 0
var calculatedMomentum = false
var targetMomentum
var grav = 2.5
var newloons = false
var timerDone = false

@export var flavor = "drone"

func _ready() -> void:
	position.x = Global.planePosition.x
	
	if Global.isBlack:
		$Drone.self_modulate = Color8(0,0,0)
		$Overlay.self_modulate = Color8(0,0,0)

func _process(_delta):
	#momentum
	if position.y <= 86 and !calculatedMomentum:
		x1 = position.x
		position.x = Global.planePosition.x
	elif !calculatedMomentum:
		momentum = snapped(x2 - x1, 0.1)
		calculatedMomentum = true
	
	settle_momentum()
	x2 = position.x
	
	move_and_collide(Vector2(momentum, grav))
	if newloons == false:
		grav -= 0.02
	else:
		grav -= 0.01
	
	if grav <= 0.2: 
		if !newloons:
			newloons = true
			$Wait.start()
		elif timerDone:
			grav -= 0.05
	
	if is_on_floor():
		grav -= 0.02
	
	if position.y < -100:
		queue_free()

func _on_wait_timeout() -> void:
	timerDone = true
	$Drone.play("NewLoons")
	$Drone.play("NewLoons")

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

func _on_eat_area_entered(area: Area2D) -> void:
	if !Global.iFrames:
		Audio.play_sound("Hurt")
		Global.iFrames = true
		Global.health -= 32
		Heart.hurt()


func _on_drone_animation_finished() -> void:
	if $Drone.frame > 30:
		$Drone.play("LoonBloon")
		$Overlay.play("LoonBloon")
		$Overlay.modulate.a = 1
