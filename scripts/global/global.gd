extends Node2D

var mario_is_dead = false

var fullscreen = false
var windowed = true

func _process(_delta):
	if Input.is_action_just_pressed("togglefullscreen") and windowed:
		windowed = false
		fullscreen = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif Input.is_action_just_pressed("togglefullscreen") and fullscreen:
		windowed = true
		fullscreen = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
