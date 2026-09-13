extends Node

@export var _body: CharacterBody2D
@export var SPEED: float = 140

var MIN_X: int = GlobalVariables.PLAYER_WIDTH / 2
var MAX_X: int = GlobalVariables.OCEAN_WIDTH - GlobalVariables.PLAYER_WIDTH / 2
var MIN_Y: int = 100
var MAX_Y: int = 144 * 5

var can_move = true

func _physics_process(_delta: float) -> void:
	if !can_move:
		return
	var direction_x := Input.get_axis("move_left", "move_right")
	var direction_y := Input.get_axis("move_up", "move_down")
	
	
	var _velocity = Vector2(direction_x, direction_y)
	var _velocity_normalized = _velocity.normalized() * SPEED
	_body.velocity = _velocity_normalized

	_body.move_and_slide()
	_body.global_position.x = clamp(_body.global_position.x, MIN_X, MAX_X)
	_body.global_position.y = clamp(_body.global_position.y, MIN_Y, MAX_Y)
	
func ToggleMovement(_can_move: bool):
	can_move = _can_move
