extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(Global.landingPos.x, Global.landingPos.y + 8)

func _process(delta: float) -> void:
	move_and_collide(Vector2(0,8))

func _on_animate_animation_finished(anim_name: StringName) -> void:
	queue_free()
