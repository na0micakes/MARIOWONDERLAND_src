extends Node2D
	
func _ready():
	$Timer.start(1.5)
	
func _on_timer_timeout():
	$transition/base/AnimationPlayer.play("fadeIn")
	$transition/base/AnimationPlayer.speed_scale = 2


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fadeIn":
		get_tree().change_scene_to_file("res://scenes/levels/menus/titlescreen.tscn")
