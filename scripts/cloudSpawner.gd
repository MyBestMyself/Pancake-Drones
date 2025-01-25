extends Node2D

var rng = RandomNumberGenerator.new()
var cloud = preload("res://scenes/cloud.tscn")

func _ready() -> void:
	Global.initialClouds = true
	
	var num = 5
	if Global.level == "Mechanical Skies":
		num = 10
	
	for x in range(num):
		add_child(cloud.instantiate())
	Global.initialClouds = false

func _on_timer_timeout() -> void:
	add_child(cloud.instantiate())
	
	if Global.level == "The Only Ocean":
		$Timer.wait_time = randf_range(1, 1.5)
	else:
		$Timer.wait_time = randf_range(0.5, 1)
	$Timer.start()
