extends Node2D

func _ready() -> void:
	Global.spawn.connect(spawn)
	
	$DroneCarrier/SpawnRate.wait_time = Global.spawnRate * 0.65
	$DroneCarrier/SpawnRate.start()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		Global.configMenuOpen = !Global.configMenuOpen
		if Global.configMenuOpen:
			Global.maxConfigId = 1
	$Label.text = str(Global.pancakeSpawnList) + " \n" + str(Global.droneSpawnList)

func spawn(scene):
	add_child(scene.instantiate())
