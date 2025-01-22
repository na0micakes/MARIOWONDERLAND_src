extends CollisionShape2D

var collision : CollisionShape2D

func _process(delta):
	if Input.is_action_just_pressed("move_down"):
		CollisionShape2D.scale.y = 3.025
