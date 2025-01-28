extends Node2D

func _ready():
	position = Vector2(Global.landingPos.x, Global.landingPos.y + 16)
	$Fireball.emitting = true
	$Fireball2.emitting = true
	$Fireball3.emitting = true
	
	$BigChunks.emitting = true
	$BreadCrumbs.emitting = true
	$DroneParts.emitting = true
	$DroneParts2.emitting = true
	$DroneParts3.emitting = true
	
	Global.cameraShakeLight.emit()
	
	if Global.isBlack:
		$BigChunks.self_modulate.v = 0
		$BreadCrumbs.self_modulate.v = 0
		$DroneParts.self_modulate.v = 0
		$DroneParts2.self_modulate.v = 0
		$DroneParts3.self_modulate.v = 0


func _on_kill_timer_timeout() -> void:
	queue_free()
