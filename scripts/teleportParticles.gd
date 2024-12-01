extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Global.landingPos
	rotation_degrees = Global.landingRot
	
	if Global.teleportsLeft == 2:
		modulate = Color8(0,255,0)
	elif Global.teleportsLeft == 1:
		modulate = Color8(0,170,0)
	else:
		modulate = Color8(55,128,0)
	
	if position.y > 150:
		$Burst.emitting = true
		$SmallBurst.emitting = true
		$SmallerBurst.emitting = true
		$Sparkles.hide()
	
	$Sparkles.emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !$Sparkles.emitting:
		queue_free()
