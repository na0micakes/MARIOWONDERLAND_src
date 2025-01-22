extends ParallaxBackground

func _process(_delta):
	scroll_base_offset -= Vector2 (50, 0) * _delta
