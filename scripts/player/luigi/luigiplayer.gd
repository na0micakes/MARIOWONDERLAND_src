extends CharacterBody2D

const WALK_FORCE = 1000
const STOP_FORCE = 9300
static var GRAVITY = 5000
const WALLJUMP_KNOCKBACK = 2500
const WALK_SPEED = 1150
static var JUMP_SPEED

var state_string = ''
var dead_string = ''
var move_string = ''
var is_dead = false
var dead_anim = false
var jump_count = 0

@export var can_move = true

@onready var _animated_sprite = $AnimatedSprite2D

func _ready()-> void:
	JUMP_SPEED = 2000
	
func _physics_process(delta):
	if is_dead:
		death()
	elif !is_dead:
		dead_string = 'false'
		
	if dead_anim:
		dead_string = 'true'
		
	if can_move:
		move_string = 'true'
	elif !can_move:
		move_string = 'false'
		
	# gravity (?)
	velocity.y += delta * GRAVITY
	
	#walking	
	var walk := WALK_SPEED * (Input.get_axis(&"move_left", &"move_right"))
	if can_move:
		# Slow down the player if they're not trying to move.
		if abs(walk) < WALK_FORCE * 0.05:
			# The velocity, slowed down a bit, and then reassigned.
			velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta - 10)
		else:
			velocity.x += walk * delta
	
	if !can_move:
		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta / 2)
			
	if is_on_floor() and can_move and $Timer.time_left <= 0 and Input.get_axis(&"move_left", &"move_right"):
		$walk_sfx.pitch_scale = randf_range(0.7, 1)
		$walk_sfx.play()
		if is_on_wall() and is_on_floor():
			$Timer.start(0.5)
		else:
			$Timer.start(0.2)
			
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
			
	if is_on_floor() and walk !=  0 and can_move:
		_animated_sprite.play("walk")
		state_string = 'walking'
	elif can_move:
		_animated_sprite.play("idle")
		state_string = 'idle'
		
		
	if is_on_wall() and is_on_floor():
		_animated_sprite.speed_scale = 0.5
	else:
		_animated_sprite.speed_scale = 1
		
	#jump shit
	if is_on_floor():
		jump_count = 0
		
	if  is_on_floor() and Input.is_action_just_pressed("act_jump") and can_move:
		jump()
		get_node("jump_sfx").play()
		$jump_sfx.pitch_scale = 1
		
	if !is_on_floor() and Input.is_action_just_released("act_jump") and can_move:
		jump_cut()
		
	if velocity.y < 0 and !is_on_floor() and !dead_anim:
			_animated_sprite.play("jump")
			state_string = 'jumping'
	elif !is_on_floor() and !dead_anim:
			_animated_sprite.play("fall")
			state_string = 'falling'
	elif !is_on_floor() and dead_anim:
		_animated_sprite.play("dead")
		
	# sprinting
	if velocity.x > 1449 and can_move:
		velocity.x = 1549
		_animated_sprite.speed_scale = 2
		state_string = 'walking 2'
		if Input.is_action_pressed("act_sprint"):
			velocity.x = 1800
			_animated_sprite.speed_scale = 2.5
			state_string = 'sprinting'
			if Input.is_action_just_released("act_sprint"):
				velocity.x = 1549
				
	if velocity.x < -1449 and can_move:
		velocity.x = -1549
		_animated_sprite.speed_scale = 2
		state_string = 'walking 2'
		if Input.is_action_pressed("act_sprint"):
			velocity.x = -1800
			_animated_sprite.speed_scale = 2.5
			state_string = 'sprinting'
			if Input.is_action_just_released("act_sprint"):
				velocity.x = -1549
		
	#walljumping
	if is_on_wall() and !is_on_floor() and Input.is_action_pressed("move_left") and Input.is_action_just_pressed("act_jump"): 
		velocity.x = WALLJUMP_KNOCKBACK
		velocity.y = -JUMP_SPEED + 950
		jump_count = 1
		get_node("jump_sfx").play()
		state_string = 'walljumping'
	elif is_on_wall() and !is_on_floor() and Input.is_action_pressed("move_right") and Input.is_action_just_pressed("act_jump"): 
		velocity.x -= WALLJUMP_KNOCKBACK
		velocity.y = -JUMP_SPEED + 950
		get_node("jump_sfx").play()
		state_string = 'walljumping'
		
	#misc
	if is_on_floor() and Input.is_action_pressed("ui_up"):
		can_move = false
		_animated_sprite.play("lookup")
		state_string = 'lookup'
	elif is_on_floor() and Input.is_action_just_released("ui_up"):
		can_move = true
			
	if is_on_floor() and Input.is_action_pressed("ui_down"):
		_animated_sprite.play("crouch")
		velocity.x = move_toward(velocity.x, Input.get_axis(&"move_left", &"move_right"), STOP_FORCE * delta)
		state_string = 'crouch'
		
	# "move_and_slide" already takes delta time into account.
	move_and_slide()
	
func death():
	$"../../BGM".stop()
	dead_anim = true
	is_dead = false
	can_move = false
	state_string = 'dead'
	GRAVITY = 0
	velocity.x = 0
	velocity.y = 0
	$CollisionShape2D.disabled = true
	$death_timer.start(0.75)
		
func jump():
	velocity.y = -JUMP_SPEED - 120
	
func jump_cut():
	if velocity.y < -700:
		velocity.y = -700

func _on_death_timer_timeout() -> void:
	JUMP_SPEED = 1650
	velocity.y = -JUMP_SPEED
	GRAVITY = 4950
	
func _on_death_area_body_entered(body: Node2D) -> void:
	is_dead = true
