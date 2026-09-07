extends Control

@onready var game_viewport: SubViewport = $SubViewport/SubViewport
@onready var output: TextureRect = $Output

func _ready():
	output.texture = game_viewport.get_texture()
