extends Node2D

func _process(delta: float) -> void:
	$Label.text = str(Global.points)
