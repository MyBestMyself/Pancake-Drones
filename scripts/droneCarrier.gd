extends AnimatedSprite2D

var pancakeQueue = []
var droneQueue = []

var spawnables = {
	"pancake" : preload("res://scenes/pancake.tscn"),
	"syrupPancake" : preload("res://scenes/syrupPancake.tscn"),
	"drone" : preload("res://scenes/drone.tscn"),
	"transformer" : preload("res://scenes/transformer.tscn"),
	"multiDrone" : preload("res://scenes/multiDrone.tscn"),
	"nest" : preload("res://scenes/nest.tscn"),
	"balloonDrone" : preload("res://scenes/balloonDrone.tscn")
}

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	Global.resetQueue.connect(reset_queues)
	reset_queues()

func _process(delta: float) -> void:
	Global.planePosition = position
	Global.planeRotation = rotation_degrees

func make():
	$SpawnRate.start()
	
	if Global.pancakeSeed.size() == 0:
		Global.pancakeSeed = [1,4,2,3, 2,1,3,4, 3,2,4,1, 4,3,1,2] 
	
	if (Global.pancakeSeedNum == Global.pancakeSeed[0] or Global.droneSpawnList == []) and Global.pancakeSpawnList != []:
		if Global.spawnRate != 0:
			Global.emit_signal("spawn", spawnables[pancakeQueue[0]])
			pancakeQueue.remove_at(0)
			if pancakeQueue.size() == 0:
				set_pancake_queue()
			
			Global.pancakeSeedNum = 0
			Global.pancakeSeed.remove_at(0)
			
	elif Global.droneSpawnList != []:
		Global.emit_signal("spawn", spawnables[droneQueue[0]])
		droneQueue.remove_at(0)
		if droneQueue.size() == 0:
			set_drone_queue()
	
	if Global.pancakeSpawnList != [] and Global.spawnRate != 0:
		Global.pancakeSeedNum += 1

func reset_queues():
	pancakeQueue = []
	droneQueue = []
	set_pancake_queue()
	set_drone_queue()

func set_pancake_queue():
	var num = 0
	
	Global.set_pancake_spawn_list()
	
	while num < Global.pancakeSpawnList.size():
		add_pancake_queue(Global.pancakeSpawnList[num])
		num += 1

func set_drone_queue():
	var num = 0
	while num < Global.droneSpawnList.size():
		AddDroneQueue(Global.droneSpawnList[num])
		num += 1

func add_pancake_queue(pancake):
	pancakeQueue.push_back(pancake)

func AddDroneQueue(drone):
	rng.randomize()
	droneQueue.insert(rng.randi_range(0,droneQueue.size()), drone)
