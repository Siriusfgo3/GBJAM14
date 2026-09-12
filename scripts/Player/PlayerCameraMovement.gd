extends Node

@export var _body: CharacterBody2D
@export var MIN_X: int = 0
@export var MAX_X: int = 1280 - 0.5 * (GlobalVariables.CAMERA_WIDTH - GlobalVariables.PLAYER_WIDTH)
@export var SPEED: float = 200

var can_move = true

func _physics_process(_delta: float) -> void:
	if not can_move:
		return
	var direction := Input.get_axis("move_left", "move_right")
	_body.velocity.x = direction * SPEED

	_body.move_and_slide()
	_body.position.x = clamp(_body.position.x, MIN_X, MAX_X)
	
func ToggleMovement(_can_move: bool):
	can_move = _can_move
