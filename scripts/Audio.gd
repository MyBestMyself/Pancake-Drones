extends Node

var currentSong = "Experimental Zone"

var songList = {
	"The Only Ocean" : preload("res://assets/audio/music/A Watered-Down Bottle of Syrup.ogg"),
	"Crustacean Caves" : preload("res://assets/audio/music/A Few Small Rocks Among Several Larger Rocks.ogg"),
	"The Ouchlands" : preload("res://assets/audio/music/A Spoonful of Sharp Things.ogg"),
	"Marble Flats" : preload("res://assets/audio/music/A Half-Empty Juice Box.ogg"),
	"Savory Swamp" : preload("res://assets/audio/music/A Neglected Soybean Plantation.ogg"),
	"Frozen Plateau" : preload("res://assets/audio/music/A Considerable Lack of Salted Popsicles.ogg"),
	"Hectic Maze" : preload("res://assets/audio/music/Heavy Metal in a Small Room.ogg"),
	"Vinethread Island" : preload("res://assets/audio/music/These Plants Would Like to Stab You.ogg"),
	"Mechanical Skies" : preload("res://assets/audio/music/Clouds Do Not Exist Yet.ogg"),
	"A Black Room" : preload("res://assets/audio/music/It's My Least Favourite Color.ogg"),
	"Chaotic Cliffs" : preload("res://assets/audio/music/Severe Hyperphagia.ogg"),
}

func stop_song():
	$Music.stop()

func set_song(song):
	if song != currentSong:
		currentSong = song
		if currentSong in songList:
			$Music.stream = songList[currentSong]
		
		if song == "Hectic Maze":
			$MazeTimer.stop()
			Global.mazeSetup = false
			$TimerTimer.start()
		
		if currentSong == "Experimental Zone":
			stop_music()
		else:
			$Music.play()

func stop_music():
	$Music.stop()

func _on_timer_timer_timeout() -> void:
	$MazeTimer.start()
	Global.mazeSetup = true

func _on_maze_timer_timeout() -> void:
	if Global.level == "Hectic Maze" and !get_tree().paused:
		Global.mazeCanShift = true
