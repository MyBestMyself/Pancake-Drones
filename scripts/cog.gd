extends Sprite2D

@export var direction = "Right"
@export var spun = false

var speed = 0.2

func _ready() -> void:
	if direction == "Right":
		speed *= -1

func _process(delta: float) -> void:
	rotation_degrees += speed
