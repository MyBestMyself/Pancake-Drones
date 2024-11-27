extends Sprite2D

var active = true
var darkCubes = [7, 11, 15, 25, 29]

var sizes = {
	0 : preload("res://sprites/game/DotThin.png"),
	1 : preload("res://sprites/game/DotBig.png"),
	2 : preload("res://sprites/game/DotWide.png"),
	3 : preload("res://sprites/game/DotWider.png")
}

@export var id = 0
@export var size = 1

func _process(_delta):
	if darkCubes.has(id):
		modulate = Color(Global.shirtColor)
	else:
		modulate = Color(Global.shirtColor)
		if Global.shirtColor.s <= 0.5:
			modulate.s = Global.shirtColor.s - 0.5
		else:
			modulate.s = 0.5
	
	if id > Global.health and active == true:
		active = false
		$GPUParticles2D.texture = sizes[size]
		$Animate.play("fall")
	
	if id <= Global.health and active == false:
		active = true
		$Animate.play("regrow")
