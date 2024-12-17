extends Sprite2D

var rng = RandomNumberGenerator.new()
var num
var rot
var momentum

func _ready():
	randomize()
	rng.randomize()
	num = rng.randi_range(0, 2)
	
	frame = num
	
	num = rng.randi_range(-3, 3)
	rotation_degrees = (num * 90)
	rot = (num * 90)
	
	$Timer.wait_time = rng.randf_range(0, 5)
	$Timer.start()

func _process(delta):
	if rotation_degrees < rot:
		rotation_degrees += momentum
		momentum -= 1
		if rotation_degrees > rot:
			rotation_degrees = rot
	
	if rotation_degrees > rot:
		rotation_degrees -= momentum
		momentum -= 1
		if rotation_degrees < rot:
			rotation_degrees = rot

func _on_timer_timeout() -> void:
	rng.randomize()
	num = rng.randi_range(1, 2)
	
	if num == 1:
		turn_clockwise()
	elif num == 2:
		turn_otherway()
	
	$Timer.wait_time = rng.randf_range(1, 5)
	$Timer.start()

func turn_clockwise():
	momentum = 13
	if rot < 360:
		rot += 90
	else:
		turn_otherway()

func turn_otherway():
	momentum = 13
	if rot > -360:
		rot -= 90
	else:
		turn_clockwise()
