extends RigidBody2D

@export var type:String = "coin"
@export var value:int = 4

signal item_pickup

func _ready():
	pass

func _on_Coin_body_entered(body):
	emit_signal("item_pickup", type, value)
	queue_free()
