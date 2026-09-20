extends Control

@onready var game_viewport: SubViewport = $SubViewport/SubViewport
@onready var output: TextureRect = $Output

@export var StartButton: Button
@export var startMenu: Control

@export var menu_music: AudioStreamPlayer

@export var help_page: Control

@export var back_button: Button

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	output.texture = game_viewport.get_texture()
	StartButton.grab_focus()

# on START_MENU, or on GB_screen
@export var ocean: Node
func _on_button_start_pressed() -> void:
	startMenu.visible = false
	menu_music.stop()
	ocean.visible = true
	ocean.process_mode = Node.PROCESS_MODE_INHERIT
	
func _on_explanation_button_pressed():
	help_page.visible = true
	back_button.grab_focus()
	
func _on_back_button_pressed():
	help_page.visible = false
	StartButton.grab_focus()
