extends Node2D

var rng = RandomNumberGenerator.new()
var crab = preload("res://scenes/crab.tscn")

func _ready() -> void:
	$Timer.wait_time = randf_range(2, 8)
	$Timer.start()

func _on_timer_timeout() -> void:
	rng.randomize()
	
	add_child(crab.instantiate())
	
	$Timer.wait_time = randf_range(2, 8)
	$Timer.start()
