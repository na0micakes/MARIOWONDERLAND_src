extends Node2D

@onready var camera = $Level_Elements/Camera2D
@onready var mario = $Level_Elements/MARIO

func _ready() -> void:
	mario.GRAVITY = 2000
	camera.canfollow_y = true
	$UI/Transition/base/AnimationPlayer.play("disappear")
	
func _on_trigger_area_body_entered(body: Node2D) -> void:
	camera.canfollow_y = false
	mario.GRAVITY = 5000
