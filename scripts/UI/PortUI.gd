class_name PortUI
extends Control

var transition_enabled: bool = false
@export var transition_overlay: Control
@export var player: CharacterBody2D
@export var port_background: Control

@export var port: Port
var port_collider: CollisionShape2D
var port_width: int
var port_height: int

func _onready():
	port_collider = port.get_collision_shape()
	port_width = port_collider.shape.get_rect().size.x

func EnableTransition():
	transition_enabled = true
	
func DisableTransition():
	transition_enabled = false

func _process(delta: float) -> void:
	UpdateTransition()


func UpdateTransition() -> void:
	if not transition_enabled:
		return
	var relative_player_position = player.position.x + (GlobalVariables.PLAYER_WIDTH / 2) - port_width - port.position.x
	transition_overlay.position.x = GlobalVariables.CAMERA_WIDTH - 2 * relative_player_position
	port_background.position.x = GlobalVariables.CAMERA_WIDTH - relative_player_position
	
	#var relative_player_position = GlobalVariables.CAMERA_WIDTH - (GlobalVariables.OCEAN_WIDTH - player.position.x - (GlobalVariables.PLAYER_WIDTH / 2))
	#transition_overlay.position.x = GlobalVariables.CAMERA_WIDTH - 2 * relative_player_position
	#port_background.position.x = GlobalVariables.CAMERA_WIDTH - relative_player_position
