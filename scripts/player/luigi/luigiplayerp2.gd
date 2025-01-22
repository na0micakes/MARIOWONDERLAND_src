extends CharacterBody2D

const WALK_FORCE = 600
const STOP_FORCE = 9300
const GRAVITY = 5000
const WALK_SPEED = 300
const JUMP_SPEED = 2250

var is_dead = false
var is_moving = false
var walking = false
var can_move = false

@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
		
	velocity.y += delta * GRAVITY
		
	var walk := WALK_SPEED * (Input.get_axis(&"p2_left", &"p2_right"))
	walking = true
	# Slow down the player if they're not trying to move.
	if abs(walk) < WALK_FORCE * 0.1:
		# The velocity, slowed down a bit, and then reassigned.
		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
	else:
		velocity.x += walk * delta
		if is_on_floor() and $Timer.time_left <= 0:
			$walk_sfx.pitch_scale = randf_range(1, 1.3)
			$walk_sfx.play()
			$Timer.start(0.2)
			
	if is_on_floor() and walk !=  0:
		_animated_sprite.play("walk")
	else:
		_animated_sprite.play("idle")
		
	if is_on_floor() and Input.is_action_just_pressed("p2_jump"):
		jump()
		get_node("jump_sfx").play()
		
	if Input.is_action_just_released("p2_jump"):
		jump_cut()
		
	if !is_on_floor():
		_animated_sprite.play("jump")
		
	# "move_and_slide" already takes delta time into account.
	move_and_slide()
	
		
	if is_on_floor() and Input.is_action_pressed("p2_down"):
		velocity.x = 0
		_animated_sprite.play("crouch")
	else:
		velocity.x += walk * delta
		
	if is_on_floor() and Input.is_action_pressed("p2_up"):
		can_move = true
		_animated_sprite.play("lookup")
		
func jump():
	velocity.y = -JUMP_SPEED
	
func jump_cut():
	if velocity.y < -700:
		velocity.y = -700
