extends Node2D

var test1_script = preload("res://scenes/levels/testmap001.tscn")

func _ready():
	$Area2D/AnimatedSprite2D.play("idle")

func _on_area_2d_area_entered(_area):
	test1_script.gain_coins(1)
	free()
