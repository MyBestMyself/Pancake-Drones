extends Camera2D

@export var strengthRange: float = 10
@export var shakeDecay: float = 1
var shake_strength = 0
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	
	Global.cameraShake.connect(shake)
	Global.cameraShakeLight.connect(light_shake)
	Global.cameraShakeTiny.connect(tiny_shake)
	

func _process(delta):
	if shake_strength > 0:
		shake_strength -= shakeDecay 
	else:
		shake_strength = 0
	offset = Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
	
	if Input.is_action_just_pressed("ui_accept"):
		shake()

func shake():
	shake_strength = strengthRange

func light_shake():
	shake_strength = strengthRange/2

func tiny_shake():
	shake_strength = strengthRange/4

func set_vibration():
	if Global.Vibration == "High":
		strengthRange = 10
	elif Global.Vibration == "Low":
		strengthRange = 5
	elif Global.Vibration == "None":
		strengthRange = 0

func _on_ShockwaveTime_timeout():
	Global.Shockwave = false

func change_zoom(direction):
	if direction == "out":
		zoom = Vector2(2,2)
	elif direction == "in":
		zoom = Vector2(1,1)
