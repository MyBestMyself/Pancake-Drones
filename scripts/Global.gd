extends Node

#Character
var hairColor = Color(1, 0.839216, 0.368627, 1)
var skinColor = Color(1, 0.952941, 0.815686, 1)
var shirtColor = Color(0, 0.8, 0.266667, 1)
var pantsColor = Color(0.043137, 0.152941, 0.815686, 1)

#Gameplay
var levelList = ["The Only Ocean", "Crustacean Caves", "The Ouchlands", "Marble Flats", "Savory Swamp", "Frozen Plateau", "Hectic Maze", "Vinethread Island", "Mechanical Skies", "A Black Room", "Chaotic Cliffs", "Experimental Zone"]
var levelNum = 7
var level = levelList[levelNum]
var points = 0
var health = 36
var iFrames = false
var isBlack = false
var walkDirection = "Right"
var planePosition = Vector2(0,0)
var planeRotation = 0
var planeSide = "Left"
var planeUnderside = []
var playerPosition = Vector2(0,0)
var playerDirection = "Right"
var landingPos
var landingRot
var landingFlavor
var splitNum
var splitSway
var splittingPos
var splitMomentum
var splitSeed
var chunkDirection
var teleportsLeft
var jumpPos
var jumpRotation
var jumpMomentum
var jumpSide
var pancakeSpawnList = ["pancake", "syrupPancake", "pancake"]
var droneSpawnList = ["drone", "drone", "transformer"]
var pancakeSeed = [1,4,2,3, 2,1,3,4, 3,2,4,1, 4,3,1,2] 
var pancakeSeedNum = 0
var pancakeCycles = 0
var mazeCanShift = false
var mazeSetup = false
var initialClouds = false

#Config
var configMenuOpen = false
var maxConfigId = 1
var spawnRate = 1
var planeCentered = false

signal resetQueue()
signal spawn(scene)
signal spawn_on_plane(scene)
signal cameraShake
signal cameraShakeLight
signal cameraShakeTiny

func set_pancake_spawn_list():
	if Global.pancakeSpawnList.has("pancake") and Global.pancakeSpawnList.has("syrupPancake"):
		Global.pancakeCycles += 1
		if Global.pancakeCycles > 18:
			Global.pancakeCycles = 1
		
		if Global.pancakeCycles == 1:
			Global.pancakeSpawnList = ["pancake", "pancake", "syrupPancake"]
		elif Global.pancakeCycles == 2:
			Global.pancakeSpawnList = ["syrupPancake", "pancake", "pancake"]
		elif Global.pancakeCycles == 3:
			Global.pancakeSpawnList = ["pancake", "syrupPancake", "pancake"]
		elif Global.pancakeCycles == 4:
			Global.pancakeSpawnList = ["pancake", "pancake", "syrupPancake"]
		elif Global.pancakeCycles == 5:
			Global.pancakeSpawnList = ["pancake", "syrupPancake", "pancake"]
		elif Global.pancakeCycles == 6:
			Global.pancakeSpawnList = ["syrupPancake", "pancake", "pancake"]
		elif Global.pancakeCycles == 7:
			Global.pancakeSpawnList = ["syrupPancake", "pancake", "pancake"]
		elif Global.pancakeCycles == 8:
			Global.pancakeSpawnList = ["pancake", "pancake", "syrupPancake"]
		elif Global.pancakeCycles == 9:
			Global.pancakeSpawnList = ["pancake", "syrupPancake", "pancake"]
		elif Global.pancakeCycles == 10:
			Global.pancakeSpawnList = ["syrupPancake", "pancake", "pancake"]
		elif Global.pancakeCycles == 11:
			Global.pancakeSpawnList = ["pancake", "syrupPancake", "pancake"]
		elif Global.pancakeCycles == 12:
			Global.pancakeSpawnList = ["pancake", "pancake", "syrupPancake"]
		elif Global.pancakeCycles == 13:
			Global.pancakeSpawnList = ["pancake", "syrupPancake", "pancake"]
		elif Global.pancakeCycles == 14:
			Global.pancakeSpawnList = ["pancake", "pancake", "syrupPancake"]
		elif Global.pancakeCycles == 15:
			Global.pancakeSpawnList = ["syrupPancake", "pancake", "pancake"]
		elif Global.pancakeCycles == 16:
			Global.pancakeSpawnList = ["pancake", "syrupPancake", "pancake"]
		elif Global.pancakeCycles == 17:
			Global.pancakeSpawnList = ["syrupPancake", "pancake", "pancake"]
		elif Global.pancakeCycles == 18:
			Global.pancakeSpawnList = ["pancake", "pancake", "syrupPancake"]
