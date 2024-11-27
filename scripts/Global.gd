extends Node

#Character
var hairColor = Color(1, 0.839216, 0.368627, 1)
var skinColor = Color(1, 0.952941, 0.815686, 1)
var shirtColor = Color(0, 0.8, 0.266667, 1)
var pantsColor = Color(0.043137, 0.152941, 0.815686, 1)

#Gameplay
var points = 0
var health = 36
var iFrames = false
var planePosition = 0
var planeRotation = 0
var playerDirection = "Right"
var landingPos
var landingFlavor
var splitNum
var splitSway
var splittingPos
var splitMomentum
var pancakeSpawnList = ["pancake", "syrupPancake", "pancake"]
var droneSpawnList = ["drone", "drone", "transformer"]
var pancakeSeed = [1,4,2,3, 2,1,3,4, 3,2,4,1, 4,3,1,2] 
var pancakeSeedNum = 0
var pancakeCycles = 0

#Config
var configMenuOpen = false
var maxConfigId = 1
var spawnRate = 1

signal resetQueue()
signal spawn(scene)

func set_pancake_spawn_list():
	if Global.pancakeSpawnList.has("pancake") and Global.pancakeSpawnList.has("syrupPancake"):
		Global.pancakeCycles += 1
		if Global.pancakeCycles > 3:
			Global.pancakeCycles = 1
		
		if Global.pancakeCycles == 1:
			Global.pancakeSpawnList = ["pancake", "pancake", "syrupPancake"]
		elif Global.pancakeCycles == 2:
			Global.pancakeSpawnList = ["syrupPancake", "pancake", "pancake"]
		elif Global.pancakeCycles == 3:
			Global.pancakeSpawnList = ["pancake", "syrupPancake", "pancake"]
