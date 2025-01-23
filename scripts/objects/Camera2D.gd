extends Camera2D

@export var MARIO : NodePath

var canfollow_y = false

func _process(_delta):
	var player = get_node(MARIO)
	global_position.x = player.global_position.x - 200
	
	if canfollow_y: global_position.y = player.global_position.y
		
