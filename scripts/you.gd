extends CharacterBody2D

var lost = false
var legs = "Idle"
var shockwave = false

var idle = preload("res://sprites/menu/body_parts/Pants1.png")
var walk1 = preload("res://sprites/menu/body_parts/Pants2.png")
var walk2 = preload("res://sprites/menu/body_parts/Pants3.png")

func _ready() -> void:
	$Body/Hair.modulate = Global.hairColor
	$Body/Pants.modulate = Global.pantsColor
	$Body/Shirt.modulate = Global.shirtColor
	$Body/Skin.modulate = Global.skinColor
	
	Global.cameraShake.connect(start_shockwave)

func _process(delta: float) -> void:
	Global.playerPosition = position
	if Global.iFrames and !$Animate.is_playing():
		if Global.health > 0:
			$Animate.play("Iframes")
		elif !lost:
			lost = true
			lose()

func _physics_process(delta: float) -> void:
	if !lost and !shockwave:
		if (Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right")) or (Input.is_action_pressed("ui_right") and !Input.is_action_pressed("ui_left")):
			if $WalkTimer.is_stopped():
				walk()
				$WalkTimer.start()
		elif (Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_right")) or (!Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right")):
			$WalkTimer.stop()
			$Body/Pants.texture = idle
			legs = "Idle"
		
		if Input.is_action_pressed("ui_left"):
			move_and_collide(Vector2(-2.25,0))
			if $Body.scale.x == 1 and !Input.is_action_pressed("ui_right"):
				Global.playerDirection = "Left"
				$Body.scale.x = -1
				$Raycasts.scale.x = -1
		
		if Input.is_action_pressed("ui_right"):
			move_and_collide(Vector2(2.25,0))
			if $Body.scale.x == -1 and !Input.is_action_pressed("ui_left"):
				Global.playerDirection = "Right"
				$Body.scale.x = 1
				$Raycasts.scale.x = 1
		
		tiny_jump()
	elif shockwave:
		$WalkTimer.stop()
		$Body/Pants.texture = idle
		legs = "Idle"
	
	move_and_collide(Vector2(0,4))

func tiny_jump():
	if $Raycasts/DetectWall.is_colliding() == true and $Raycasts/DetectFloor.is_colliding() == true and $Raycasts/DetectHighWall.is_colliding() == false and $Raycasts/DetectRise.is_colliding() == false:
		move_and_collide(Vector2(0,-4))
		move_and_collide(Vector2(2.25 * $Raycasts.scale.x , 0))

func walk():
	if legs == "Idle" or legs == "Walk1":
		$Body/Pants.texture = walk2
		legs = "Walk2"
	else:
		$Body/Pants.texture = walk1
		legs = "Walk1"

func lose():
	$Hitbox/CollisionShape2D.disabled = true
	$Toes.disabled = true
	if $Body.scale.x > 0:
		rotation_degrees = -90
	else:
		rotation_degrees = 90
	position.y += 20
	
	$WalkTimer.stop()
	$Body/Skin.texture = preload("res://sprites/menu/body_parts/Skin3.png")
	$Body/Pants.texture = preload("res://sprites/menu/body_parts/Pants1.png")
	$Body/Shirt.texture = preload("res://sprites/menu/body_parts/Shirt1.png")
	$Body/Teeth.hide()
	
	$Body/Hair.rotation_degrees = 0
	$Body/Hair.position = Vector2(0,0)
	legs = "LOSE"
	
	IrisWipe.wipe()
	Global.iFrames = false

func _on_animate_animation_finished(anim_name: StringName) -> void:
	Global.iFrames = false

func start_shockwave():
	shockwave = true
	$ShockwaveTImer.start()

func _on_shockwave_t_imer_timeout() -> void:
	shockwave = false
