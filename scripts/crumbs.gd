extends Node2D

var grav
var fall

var rng = RandomNumberGenerator.new()

func _ready():
	position = Global.landingPos
	position.y += 25
	grav = -1
	randomize()
	if Global.playerDirection == "Right":
		fall = 0
	else:
		fall = 1
	$Sprite.frame = rng.randi_range(0,3)

func _process(delta):
	if fall == 0:
		position.x += 1.5
	elif fall == 1:
		position.x -= 1.5
	position.y += grav
	grav += 0.25 
	modulate.a -= 0.05
	
	if modulate.a <= 0:
		queue_free()
