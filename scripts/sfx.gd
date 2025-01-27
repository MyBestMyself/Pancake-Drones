extends AudioStreamPlayer

var rng = RandomNumberGenerator.new()

var soundList = {
	#name, file, pitch
	"Hurt Small" : {"file": preload("res://assets/audio/sfx/Hurt.wav"), "pitch": 1},
	"Hurt" : {"file": preload("res://assets/audio/sfx/Hurt.wav"), "pitch": 0.8},
	"Hurt Big" : {"file": preload("res://assets/audio/sfx/Hurt.wav"), "pitch": 0.6},
	"Splat1" : {"file" : preload("res://assets/audio/sfx/Splat1.wav"), "pitch": 1},
	"Splat2" : {"file" : preload("res://assets/audio/sfx/Splat2.wav"), "pitch": 1},
	"Munch1" : {"file" : preload("res://assets/audio/sfx/Munch1.wav"), "pitch": 1},
	"Munch2" : {"file" : preload("res://assets/audio/sfx/Munch2.wav"), "pitch": 1},
	"Munch3" : {"file" : preload("res://assets/audio/sfx/Munch3.wav"), "pitch": 1},
	}

func _ready() -> void:
	rng.randomize()
	var num = ""
	
	if Audio.currentSound == "Splat":
		num = randi_range(1, 2)
	if Audio.currentSound == "Munch":
		num = randi_range(1, 3)
	
	var currentSound = str(Audio.currentSound) + str(num)
	if currentSound in soundList:
		stream = soundList[currentSound]["file"]
		pitch_scale = soundList[currentSound]["pitch"]
		play()
	else:
		queue_free()

func _on_finished() -> void:
	queue_free()
