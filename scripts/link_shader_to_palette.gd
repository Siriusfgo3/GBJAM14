extends TextureRect

func _ready():
	var shader_material := material as ShaderMaterial

	shader_material.set_shader_parameter(
		"darkest",
		GBPalette.DARKEST
	)

	shader_material.set_shader_parameter(
		"dark",
		GBPalette.DARK
	)

	shader_material.set_shader_parameter(
		"light",
		GBPalette.LIGHT
	)

	shader_material.set_shader_parameter(
		"lightest",
		GBPalette.LIGHTEST
	)
