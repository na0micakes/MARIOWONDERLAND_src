extends Camera2D

@export var LUIGI : NodePath

func _process(delta):
	var luigi_node = get_node(LUIGI)
	global_position.x = luigi_node.global_position.x
