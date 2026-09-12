class_name PortUI
extends Control

var transition_enabled: bool = false
@export var transition_overlay: Control
@export var player: CharacterBody2D
@export var port_background: Control

func EnableTransition():
	transition_enabled = true

func DisableTransition():
	transition_enabled = false
	
func _process(delta: float) -> void:
	UpdateTransition()
	
	
func UpdateTransition() -> void:
	if not transition_enabled:
		return
	var relative_player_position = player.position.x - (GlobalVariables.OCEAN_WIDTH - GlobalVariables.CAMERA_WIDTH - 0.5 * (GlobalVariables.CAMERA_WIDTH - GlobalVariables.PLAYER_WIDTH ))
	transition_overlay.position.x = GlobalVariables.CAMERA_WIDTH - 2 * relative_player_position
	port_background.position.x = GlobalVariables.CAMERA_WIDTH - relative_player_position
