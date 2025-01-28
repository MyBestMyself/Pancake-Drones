extends Node2D


func _ready():
	position = Vector2(Global.landingPos.x, Global.landingPos.y + 16)
	$BigChunks.emitting = true
	$BreadCrumbs.emitting = true
	$ButterSquares.emitting = true
	
	if Global.isBlack:
		modulate = Color8(0,0,0)

func _process(delta):
	if $ButterSquares.emitting == false:
		queue_free()
