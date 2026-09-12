class_name SeaportUI
extends Control

var transition_enabled: bool = false
@export var transition_overlay: Control
@export var player: CharacterBody2D
@export var port_background: Control

@export var seaport: Seaport
var seaport_collider: CollisionShape2D
var seaport_height: int

func _onready():
	seaport_collider = seaport.get_collider()
	seaport_height = seaport_collider.shape.get_rect().size.y

func EnableTransition():
	transition_enabled = true

func DisableTransition():
	transition_enabled = false
	
func _process(delta: float) -> void:
	UpdateTransition()
	
	
func UpdateTransition() -> void:
	if not transition_enabled:
		return
	var relative_player_position = player.position.y + (GlobalVariables.PLAYER_HEIGHT / 2) - seaport_height - seaport.position.y
	transition_overlay.position.y = GlobalVariables.CAMERA_HEIGHT - 2 * relative_player_position
	port_background.position.y = GlobalVariables.CAMERA_HEIGHT - relative_player_position
