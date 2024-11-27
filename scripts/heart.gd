extends Node2D

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	sync()

func sync():
	$Back.self_modulate = Color(Global.shirtColor)
	show()

func hurt():
	$Hurt.stop()
	rng.randomize()
	var hurt = rng.randi_range(1 , 2)
	if hurt == 1:
		$Hurt.play("hurt1")
	else:
		$Hurt.play("hurt2")
