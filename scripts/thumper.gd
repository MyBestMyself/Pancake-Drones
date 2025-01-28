extends Node2D

var x1 = 0
var x2 = 0
var momentum
var jumping = false

var thumper2 = preload("res://scenes/thumper2.tscn")

func _ready() -> void:
	hide()
	position = Global.planePosition
	Global.planeUnderside.push_back("me")
	$Crawl.play("CrawlLeft")
	
	if Global.isBlack:
		$Drone.self_modulate = Color8(0,0,0)

func _process(delta: float) -> void:
	x1 = Global.planePosition.x
	momentum = snapped(x2 - x1, 0.1)
	x2 = Global.planePosition.x
	
	if Global.planeUnderside.size() > 1:
		if !jumping:
			jumping = true
			Global.planeUnderside.remove_at(0)
			$Jump.play("Jump")

func jump():
	Global.jumpPos = Global.planePosition
	Global.jumpRotation = Global.planeRotation + 180
	Global.jumpMomentum = momentum
	Global.emit_signal("spawn", thumper2)
	queue_free()

func _on_detect_area_entered(area: Area2D) -> void:
	if !jumping:
		jumping = true
		Global.planeUnderside.remove_at(0)
		jump()

func _on_brace_area_entered(area: Area2D) -> void:
	$Drone.frame = 1
	$Drone/Eye.position.y = 6

func _on_brace_area_exited(area: Area2D) -> void:
	$Drone.frame = 0
	$Drone/Eye.position.y = 2

func stop_animation():
	$Drone.stop()
