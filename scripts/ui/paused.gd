extends Control

var option = ''
var canPress = true

@export var pause_btn : NodePath
@export var jump_btn : NodePath
@export var joystick : NodePath

func _ready():
	visible = false
	
var _is_paused:bool = false:
	set(value):
		_is_paused = value
		get_tree().paused = _is_paused
		visible = _is_paused
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and canPress:
		$pause_sfx.play()
		_is_paused = !_is_paused
		$PauseAnimations.play("intro")
		if !_is_paused:
			$"BGM".stop()
			$PauseAnimations.play("RESET")
	
func _on_resume_btn_pressed() -> void:
	if canPress:
		$pause_sfx.play()
		$"BGM".stop()
		$PauseAnimations.play("RESET")
		_is_paused = false
	
func _on_restart_btn_pressed() -> void:
	if canPress:
		canPress = false
		option = 'restart'
		$PauseAnimations.play("musicFadeOut")
		$"transition/base/AnimationPlayer".play("appear")
		$"transition/base/AnimationPlayer".speed_scale = 1.5
	
func _on_quit_btn_pressed() -> void:
	if canPress:
		canPress = false
		option = 'quit'
		$PauseAnimations.play("musicFadeOut")
		$"transition/base/AnimationPlayer".play("appear")
		$"transition/base/AnimationPlayer".speed_scale = 1.5
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "appear":
		match option:
			'restart':
				_is_paused = false
				get_tree().reload_current_scene()
			'quit':
				_is_paused = false
				get_tree().change_scene_to_file("res://scenes/levels/menus/titlescreen.tscn")
