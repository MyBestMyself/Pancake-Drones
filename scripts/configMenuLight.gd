extends Node2D

@export var id = 1

func _ready() -> void:
	if Global.configMenuOpen:
		$Animate.play("Resize")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if Global.configMenuOpen:
			$Timer.wait_time = id * 0.05
		else:
			$Timer.wait_time = (Global.maxConfigId + 1 - id) * 0.05
		$Timer.start()

func _on_timer_timeout() -> void:
	if Global.configMenuOpen:
		Global.maxConfigId = id
		if $Animate.current_animation_position < 0.2:
			$Animate.play("Resize")
	else:
		if $Animate.current_animation_position > 0:
			$Animate.play_backwards("Resize")
