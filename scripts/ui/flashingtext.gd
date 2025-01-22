extends RichTextLabel

@export var speed: int = 5
@export var fade: bool = false

var time = 0
var sinTime = 0
var _visible = true

func pressenter():
	if !fade:
		if sinTime > 0:
			_visible = true
		else:
			_visible = false
	else:
		_visible = true
		modulate.a = sinTime
	visible = _visible
	
func _physics_process(_delta):
	time += _delta
	sinTime = sin(time*speed)
	pressenter()
