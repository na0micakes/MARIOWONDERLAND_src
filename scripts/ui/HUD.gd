extends Control

@export var time: float = 400
@export var seconds: float
@export var stop = false
@export var canDisplay = true

func _process(_delta):
	if !stop:
		time -= _delta
		
	seconds = fmod(time, 400)
	if canDisplay:
		$TIME/timer.text =  "%03d" % seconds
	
	if seconds < 0:
		stop = true
