extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Animate.play("Open")

func wipe():
	position = Global.playerPosition
	$Animate.play("Wipe")

func reload():
	get_tree().reload_current_scene()
	position = Vector2(192, 176)
