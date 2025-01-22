extends AnimatedSprite2D

func _process(_delta):
	
	if Input.is_action_pressed("p2_left"):
		flip_h = true
		
	elif Input.is_action_pressed("p2_right"):
		flip_h = false
		
