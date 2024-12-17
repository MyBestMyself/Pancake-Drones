extends Node

var currentSong = "Experimental Zone"

func stop_song():
	$Music.stop()

func set_song(song):
	if song != currentSong:
		currentSong = song
		if song == "Hectic Maze":
			$Music.stream = preload("res://assets/audio/music/Heavy Metal in a Small Room.ogg")
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
