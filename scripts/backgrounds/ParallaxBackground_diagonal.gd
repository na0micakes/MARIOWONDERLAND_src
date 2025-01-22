extends ParallaxBackground

func _process(_delta):
	scroll_base_offset -= Vector2(200, 200) * _delta
