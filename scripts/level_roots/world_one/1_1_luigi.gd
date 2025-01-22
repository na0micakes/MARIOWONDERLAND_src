extends Node2D

@export var MARIO : NodePath

@onready var hud = $UI/HUD/Control
@onready var mario = $Level_Elements/LUIGI
@onready var mariocollision = $Level_Elements/LUIGI/CollisionShape2D

var score = 00000

var timeover = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/Transition/base/AnimationPlayer.play("disappear_star")
	$UI/Transition/base/AnimationPlayer.speed_scale = 1.5
	$Intro_Cutscene/Timer.start(1.6)
	mario.GRAVITY = 0
	mario.can_move = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var player = get_node(MARIO)
	
	if hud.seconds < 0 and !timeover:
		timeover = true
		mario.is_dead = true
	
func intro_cutscene():
	$Level_Elements/LUIGI/jump_sfx.play()
	mario.GRAVITY = 5000
	mario.velocity.y = -mario.JUMP_SPEED - 1125
	mariocollision.disabled = true
	$Intro_Cutscene/CollisionTimer.start(0.96)
	
func _on_timer_timeout() -> void:
	intro_cutscene()
	
func _on_collision_timer_timeout() -> void:
	$Intro_Cutscene/AnimationPlayer.play("appear")
	mariocollision.disabled = false
	mario.can_move = true
	$BGM.play()
