extends Control

@onready var game_viewport: SubViewport = $SubViewport/SubViewport
@onready var output: TextureRect = $Output

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	output.texture = game_viewport.get_texture()
