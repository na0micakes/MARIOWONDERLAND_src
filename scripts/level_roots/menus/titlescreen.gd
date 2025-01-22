extends Node2D

var pressed = true 

func _ready():
	$transition/base/AnimationPlayer.play("disappear_star")
	$transition/base/AnimationPlayer.speed_scale = 1.2
	
func _process(_delta):
		if pressed and Input.is_action_pressed("ui_accept"):
			$RichTextLabel.visible = false
			$CanvasLayer.visible = true
	
func _on_quit_pressed():
	get_tree().quit()
	
func _on_singleplayer_pressed():
	$transition/base/AnimationPlayer.play("appear_star")
	$transition/base/AnimationPlayer.speed_scale = 1.75
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "appear_star":
		get_tree().change_scene_to_file("res://scenes/levels/menus/characterselect.tscn")
