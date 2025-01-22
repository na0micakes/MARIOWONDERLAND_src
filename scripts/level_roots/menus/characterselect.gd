extends Node2D

var canAct = true

func _ready():
	$AnimationPlayer.play("INTRO")
	$Misc/transition/base/AnimationPlayer.play("disappear")
	$Misc/transition/base/AnimationPlayer.speed_scale = 2
	
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel") and canAct:
		$Misc/transition/base/AnimationPlayer.play("appear")
		canAct = false
		
func _on_mario_pressed():
	if canAct:
		$Misc/transition/base/AnimationPlayer.play("appear_mario")
	
func _on_luigi_pressed():
	if canAct:
		$Misc/transition/base/AnimationPlayer.play("appear_luigi")
	
		
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "appear":
			get_tree().change_scene_to_file("res://scenes/levels/menus/titlescreen.tscn")
	elif anim_name == "appear_mario":
		get_tree().change_scene_to_file("res://scenes/levels/world_one/1-1_mario.tscn")
	elif anim_name == "appear_luigi":
		get_tree().change_scene_to_file("res://scenes/levels/world_one/1-1_luigi.tscn")

func _on_animation_player_animation_started(anim_name: StringName) -> void:
	match anim_name:
		"appear_mario", "appear_luigi":
			$Misc/transition/base/AnimationPlayer.speed_scale = 0.85
			canAct = false
