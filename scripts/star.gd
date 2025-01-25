extends AnimatedSprite2D

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	
	position = Vector2(randi_range(-5, 145), randi_range(-5, 95))
	play()


func _on_animation_finished() -> void:
	queue_free()
