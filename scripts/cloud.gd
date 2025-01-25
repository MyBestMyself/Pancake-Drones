extends Sprite2D

var rng = RandomNumberGenerator.new()
var speed = 0

func _ready() -> void:
	rng.randomize()
	
	speed = randf_range(0.2, 0.5)
	
	if Global.level == "Mechanical Skies":
		position.y = randf_range(0, 75)
	else:
		position.y = randf_range(0, 50)
	
	frame = randi_range(0, 7)
	scale.x = randi_range(3, 5)
	scale.y = randi_range(3, 5)
	
	#initialize clouds
	if Global.initialClouds:
		position.x = randf_range(0, 200)
	
	#direction
	var num = randi_range(0, 1)
	var num2 = randi_range(0,1)
	if num == 1:
		scale.x *= -1
	if num2 == 1:
		scale.y *= -1

func _process(delta: float) -> void:
	position.x += speed
	
	if position.x > 250:
		queue_free()
