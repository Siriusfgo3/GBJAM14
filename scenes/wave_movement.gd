extends TextureRect

@export var speed := 100.0

var offset := 0.0

func _process(delta):
	offset += speed * delta
	texture_offset.x = offset
