extends Sprite2D

var rng = RandomNumberGenerator.new()
var speed

func _ready() -> void:
	rng.randomize()
	
	position.y = rng.randf_range(67, 86)
	var scalenum = rng.randf_range(0.85, 1)
	scale = Vector2(scalenum, scalenum)
	speed = rng.randf_range(0.25, 0.5)
	
	if position.y > 75:
		z_index = 4
	
	var num = randi_range(0, 1)
	if num == 0:
		position.x = 0
	else:
		position.x = 160
		speed *= -1

func _process(delta: float) -> void:
	position.x += speed
	
	if position.x < 0 or position.x > 160:
		queue_free()
