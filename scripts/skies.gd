extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BackgroundPlatforms/FloatingPlatform/Float.play("Float")
	$BackgroundPlatforms/FloatingPlatform/Float.seek(1) 
	
	$BackgroundPlatforms/FloatingPlatform2/Float.play("Float")
	$BackgroundPlatforms/FloatingPlatform2/Float.seek(3)
	
	$BackgroundPlatforms/FloatingPlatform3/Float.play("Float")
	$BackgroundPlatforms/FloatingPlatform3/Float.seek(5)
	
	$BackgroundPlatforms/FloatingPlatform4/Float.play("Float")
	$BackgroundPlatforms/FloatingPlatform4/Float.seek(2)
	
	$BackgroundPlatforms/FloatingPlatform5/Float.play("Float")
	$BackgroundPlatforms/FloatingPlatform5/Float.seek(4)
