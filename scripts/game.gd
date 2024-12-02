extends Node2D

var levels = {
	"Experimental Zone" : preload("res://scenes/levels/experimental.tscn"),
	"The Only Ocean" : preload("res://scenes/levels/ocean.tscn"),
	"Crustacean Caves" : preload("res://scenes/levels/caves.tscn"),
	"The Ouchlands" : preload("res://scenes/levels/ouchlands.tscn"),
	"Marble Flats" : preload("res://scenes/levels/flats.tscn"),
	"Savory Swamp" : preload("res://scenes/levels/swamp.tscn"),
	"Frozen Plateau" : preload("res://scenes/levels/plateau.tscn"),
	"Hectic Maze" : preload("res://scenes/levels/maze.tscn"),
	"Vinethread Island" : preload("res://scenes/levels/island.tscn"),
	"Mechanical Skies" : preload("res://scenes/levels/skies.tscn"),
	"A Black Room" : preload("res://scenes/levels/room.tscn"),
	"Chaotic Cliffs" : preload("res://scenes/levels/cliffs.tscn")
}

func _ready() -> void:
	Global.spawn.connect(spawn)
	Global.spawn_on_plane.connect(spawn_on_plane)
	
	add_child(levels[Global.levelList[Global.levelNum]].instantiate())
	
	Global.health = 36
	Global.points = 0
	Global.planeUnderside = []
	
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

func spawn_on_plane(scene):
	$DroneCarrier.add_child(scene.instantiate())
