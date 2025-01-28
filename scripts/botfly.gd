extends Node2D

var x1
var x2
var momentum
var speed = 0
var woundup = false
var flyaway = false

@export var flavor = "drone"

func _ready() -> void:
	position = Vector2(Global.planePosition.x, 32.333)
	
	if Global.isBlack:
		get_parent().get_node("Drone").play("black")
	else:
		get_parent().get_node("Drone").play("default")

func _process(_delta):
	#momentum
	if !flyaway:
		if position.y <= 86:
			x1 = position.x
			position.x = Global.planePosition.x
		elif momentum == null:
			momentum = snapped(x2 - x1, 0.1)
		x2 = position.x
	
	rotation = global_position.direction_to(Global.playerPosition).angle()
	if flyaway:
		position -= 3.50 * transform.x
	else:
		position += speed * transform.x
	
	if speed < 2 and !woundup:
		speed += 0.02
	elif speed > 1:
		woundup = true
		speed -= 0.01
	
	if momentum != null:
		position.x += momentum
		settle_momentum()
	
	if position.y >= 145:
		if Global.health <= 0 or Global.iFrames:
			get_parent().get_node("Drone").light_mask = 7
			$KillTimer.start()
			flyaway = true

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
		
		get_parent().get_node("Drone").light_mask = 7
		$KillTimer.start()
		flyaway = true


func _on_flyaway_timeout() -> void:
	get_parent().get_node("Drone").light_mask = 7
	$KillTimer.start()
	flyaway = true


func _on_kill_timer_timeout() -> void:
	queue_free()
