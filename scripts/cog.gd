extends Sprite2D

@export var direction = "Right"
@export var spun = false

func _ready() -> void:
	if spun:
		if direction == "Right":
			frame += 3
		else:
			frame += 6

func _on_timer_timeout() -> void:
	if direction == "Right":
		if spun:
			frame -= 3
			spun = false
		else:
			frame += 3
			spun = true
	else:
		if spun:
			frame -= 6
			spun = false
		else:
			frame += 6
			spun = true
