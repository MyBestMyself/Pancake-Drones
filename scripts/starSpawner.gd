extends Node2D

var star = preload("res://scenes/star.tscn")
var rng = RandomNumberGenerator.new()

func _on_timer_timeout() -> void:
	rng.randomize()
	
	add_child(star.instantiate())
	$Timer.wait_time = rng.randf_range(0.01, 0.1)
	$Timer.start()
