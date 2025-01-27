extends Node2D

func _ready():
	position = Global.landingPos
	$Fireball2.emitting = true
	$Fireball3.emitting = true
	
	$BigChunks.emitting = true
	$BreadCrumbs.emitting = true
	#shake camera
	Global.cameraShakeTiny.emit()
	
	if Global.isBlack:
		$BigChunks.self_modulate.v = 0
		$BreadCrumbs.self_modulate.v = 0

func _on_explosion_area_entered(area: Area2D) -> void:
	if !Global.iFrames:
		Audio.play_sound("Hurt")
		Global.iFrames = true
		Global.health -= 32
		Heart.hurt()

func _on_animate_animation_finished(anim_name: StringName) -> void:
	queue_free()
