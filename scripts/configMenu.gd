extends Node2D

func _ready():
	$"SpawnList/Pancakes/1".set_pressed_no_signal(Global.pancakeSpawnList.has("pancake"))
	$"SpawnList/Pancakes/2".set_pressed_no_signal(Global.pancakeSpawnList.has("syrupPancake")) 
	$"SpawnList/Mimetic/3".set_pressed_no_signal(Global.droneSpawnList.has("drone"))
	$"SpawnList/Mimetic/4".set_pressed_no_signal(Global.droneSpawnList.has("transformer"))
	$"SpawnList/Mimetic2/5".set_pressed_no_signal(Global.droneSpawnList.has("multiDrone"))
	$"SpawnList/Mimetic2/6".set_pressed_no_signal(Global.droneSpawnList.has("nest"))
	$"SpawnList/Aerodynamic/7".set_pressed_no_signal(Global.droneSpawnList.has("balloonDrone")) 
	$"SpawnList/Aerodynamic/8".set_pressed_no_signal(Global.droneSpawnList.has("telephony"))
	$"SpawnList/Aerodynamic2/9".set_pressed_no_signal(Global.droneSpawnList.has("kiteDrone"))
	$"SpawnList/Aerodynamic2/10".set_pressed_no_signal(Global.droneSpawnList.has("botfly"))
	$"SpawnList/Acrobatic/11".set_pressed_no_signal(Global.droneSpawnList.has("IEDrone"))
	$"SpawnList/Acrobatic/12".set_pressed_no_signal(Global.droneSpawnList.has("sparkler"))
	$"SpawnList/Acrobatic2/13".set_pressed_no_signal(Global.droneSpawnList.has("stuntDrone")) 
	$"SpawnList/Acrobatic2/14".set_pressed_no_signal(Global.droneSpawnList.has("thumper"))
	
	$"SpawnList/Center Plane/Center Plane".set_pressed_no_signal(Global.planeCentered)
	$SpawnList/Level/Label.text = "Level " + str(Global.levelNum)


func _on__pancake_toggled(toggled_on: bool) -> void:
	if toggled_on and !Global.pancakeSpawnList.has("pancake"):
		Global.pancakeSpawnList.append("pancake")
		Global.pancakeSpawnList.append("pancake")
	else:
		Global.pancakeSpawnList.erase("pancake")
		Global.pancakeSpawnList.erase("pancake")
	Global.resetQueue.emit()

func _on__syrupPancake_toggled(toggled_on: bool) -> void:
	if toggled_on and !Global.pancakeSpawnList.has("syrupPancake"):
		Global.pancakeSpawnList.append("syrupPancake")
	else:
		Global.pancakeSpawnList.erase("syrupPancake")
	Global.resetQueue.emit()

func _on__drone_toggled(toggled_on: bool) -> void:
	if toggled_on and !Global.droneSpawnList.has("drone"):
		Global.droneSpawnList.append("drone")
		Global.droneSpawnList.append("drone")
	else:
		Global.droneSpawnList.erase("drone")
		Global.droneSpawnList.erase("drone")
	Global.resetQueue.emit()

func _on__transformer_toggled(toggled_on: bool) -> void:
	if toggled_on and !Global.droneSpawnList.has("transformer"):
		Global.droneSpawnList.append("transformer")
	else:
		Global.droneSpawnList.erase("transformer")
	Global.resetQueue.emit()

func _on__multiDrone_toggled(toggled_on: bool) -> void:
	if toggled_on and !Global.droneSpawnList.has("multiDrone"):
		Global.droneSpawnList.append("multiDrone")
	else:
		Global.droneSpawnList.erase("multiDrone")
	Global.resetQueue.emit()

func _on__nest_toggled(toggled_on: bool) -> void:
	if toggled_on and !Global.droneSpawnList.has("nest"):
		Global.droneSpawnList.append("nest")
	else:
		Global.droneSpawnList.erase("nest")
	Global.resetQueue.emit()

func _on__balloonDrone_toggled(toggled_on: bool) -> void:
	if toggled_on and !Global.droneSpawnList.has("balloonDrone"):
		Global.droneSpawnList.append("balloonDrone")
	else:
		Global.droneSpawnList.erase("balloonDrone")
	Global.resetQueue.emit()

func _on__telephony_toggled(toggled_on: bool) -> void:
	if toggled_on and !Global.droneSpawnList.has("telephony"):
		Global.droneSpawnList.append("telephony")
	else:
		Global.droneSpawnList.erase("telephony")
	Global.resetQueue.emit()

func _on__kiteDrone_toggled(toggled_on: bool) -> void:
	if toggled_on and !Global.droneSpawnList.has("kiteDrone"):
		Global.droneSpawnList.append("kiteDrone")
	else:
		Global.droneSpawnList.erase("kiteDrone")
	Global.resetQueue.emit()

func _on__botfly_toggled(toggled_on: bool) -> void:
	if toggled_on and !Global.droneSpawnList.has("botfly"):
		Global.droneSpawnList.append("botfly")
	else:
		Global.droneSpawnList.erase("botfly")
	Global.resetQueue.emit()

func _on__IEDrone_toggled(toggled_on: bool) -> void:
	if toggled_on and !Global.droneSpawnList.has("IEDrone"):
		Global.droneSpawnList.append("IEDrone")
	else:
		Global.droneSpawnList.erase("IEDrone")
	Global.resetQueue.emit()

func _on__sparkler_toggled(toggled_on: bool) -> void:
	if toggled_on and !Global.droneSpawnList.has("sparkler"):
		Global.droneSpawnList.append("sparkler")
	else:
		Global.droneSpawnList.erase("sparkler")
	Global.resetQueue.emit()

func _on__stuntDrone_toggled(toggled_on: bool) -> void:
	if toggled_on and !Global.droneSpawnList.has("stuntDrone"):
		Global.droneSpawnList.append("stuntDrone")
	else:
		Global.droneSpawnList.erase("stuntDrone")
	Global.resetQueue.emit()

func _on__thumper_toggled(toggled_on: bool) -> void:
	if toggled_on and !Global.droneSpawnList.has("thumper"):
		Global.droneSpawnList.append("thumper")
	else:
		Global.droneSpawnList.erase("thumper")
	Global.resetQueue.emit()

func _on_center_plane_toggled(toggled_on: bool) -> void:
	Global.planeCentered = toggled_on

func _on_left_pressed() -> void:
	$SpawnList/Level/Left.disabled = true
	$SpawnList/Level/Right.disabled = true
	
	Global.levelNum -= 1
	if Global.levelNum < 0:
		Global.levelNum = Global.levelList.size() - 1
	IrisWipe.quick_wipe()

func _on_right_pressed() -> void:
	$SpawnList/Level/Left.disabled = true
	$SpawnList/Level/Right.disabled = true
	
	Global.levelNum += 1
	if Global.levelNum > Global.levelList.size() - 1:
		Global.levelNum = 0
	IrisWipe.quick_wipe()
