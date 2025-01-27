extends CharacterBody2D

var speed = 0
var on_edge = false
var jumping = false
var grav = 1
var gotup = false
var direction

func _ready():
	position = Global.jumpPos
	if position.x < 192:
		direction = "left"
		$Drone.scale.x *= -1
		$Eye.scale.x *= -1
		$Raycasts.scale.x *= -1
		$Animate.play("turnLeft")
	else:
		direction = "right"
		$Animate.play("turnRight")
	
	set_impact_color()
	$Impact.emitting = true
	$Impact2.emitting = true
	
	Global.cameraShake.emit()

func set_impact_color():
	var colorsMap = {
		"The Only Ocean" : Color8(0, 32, 128),
		"Crustacean Caves" : Color8(64, 64, 64),
		"The Ouchlands" : Color8(140, 7, 7),
		"Marble Flats" : Color8(231, 147, 23),
		"Savory Swamp" : Color8(98, 66, 96),
		"Frozen Plateau" : Color8(255, 255, 255),
		"Hectic Maze" : Color8(129, 129, 129),
		"Vinethread Island" : Color8(129, 129, 129),
		"Mechanical Skies" : Color8(80, 87, 89),
		"A Black Room" : Color8(0, 0, 0),
		"Chaotic Cliffs" : Color8(75, 61, 50),
	}
	var impactColor
	if Global.level in colorsMap:
		impactColor = colorsMap[Global.level]
	else:
		impactColor = Color8(89, 89, 89)
	
	$Impact.modulate = impactColor
	$Impact2.modulate = impactColor

func _process(delta: float) -> void:
	if gotup and position.y > 190: 
		position.y -= grav
		grav -= .025 
	elif gotup and position.y <= 190: 
		position.y = 181
		gotup = false
	
	if position.y > 75:
		position.x += speed
	
	if !is_on_floor() and !jumping:
		tiny_jump()
		move_and_collide(Vector2(0,4))
	
	if jumping:
		if direction == "left":
			position.x -= 2
		elif direction == "right":
			position.x += 2
		position.y += grav
		grav += 0.25 
		
		if position.y > 250:
			queue_free()

func tiny_jump():
	if $Raycasts/DetectWall.is_colliding() and $Raycasts/DetectFloor.is_colliding() and !$Raycasts/DetectHighWall.is_colliding() and !$Raycasts/DetectRise.is_colliding():
		move_and_collide(Vector2(0,-4))
		if direction == "right":
			move_and_collide(Vector2(2.25,0))
		else:
			move_and_collide(Vector2(-2.25,0))

func play_animation():
	$Drone.play()

func getup():
	gotup = true

func walk():
	$Drone.frame = 0
	if direction == "left":
		$Drone.play("DroneWalkLeft")
		speed = -0.8
	elif direction == "right":
		$Drone.play("DroneWalkRight")
		speed = 0.8

func _on_drone_frame_changed() -> void:
	if on_edge and !jumping:
		jumping = true
		$Eye.position.y = 2
		grav = -2

func _on_jump_area_entered(area: Area2D) -> void:
	if !jumping:
		$Drone.frame = 0
		speed = 0
		$Drone.stop()
		on_edge = true
		$Eye.position.y = 6
		if direction == "left":
			$Drone.play("DroneJumpLeft")
		elif direction == "right":
			$Drone.play("DroneJumpRight")
