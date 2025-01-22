
extends ColorRect

signal finished

func _fade_out():
	$AnimationPlayer.play_backwards("fadeIn")
	
func _on_AnimationPlayer_animation_finished(animname):
	emit_signal("finished")
