extends Node2D

var rng = RandomNumberGenerator.new()
var cloud = preload("res://scenes/cloud.tscn")

func _ready() -> void:
	Global.initialClouds = true
	for x in range(10):
		add_child(cloud.instantiate())
	Global.initialClouds = false

func _on_timer_timeout() -> void:
	add_child(cloud.instantiate())
	$Timer.wait_time = randf_range(0.5, 1)
	$Timer.start()
