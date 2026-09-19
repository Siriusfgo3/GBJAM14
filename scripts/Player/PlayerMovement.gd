extends Node
class_name PlayerMovement

@export var _body: CharacterBody2D

@export var SPEED: float = 200
@export var ACCELERATION: int = 2
@export var FRICTION: int = 8


var MIN_X: int = GlobalVariables.PLAYER_WIDTH / 2
var MAX_X: int = GlobalVariables.OCEAN_WIDTH - GlobalVariables.PLAYER_WIDTH / 2
var MIN_Y: int = 32 #For at teste animationen, husk at sætte tilbage på 100
var MAX_Y: int = 144 * 2

var direction: Vector2 = Vector2.ZERO

var can_move = true


func _physics_process(_delta: float) -> void:
	if !can_move:
		return

	direction = Vector2(Input.get_axis("move_left", "move_right"), 
							Input.get_axis("move_up", "move_down")).normalized()
	var _velocity = lerp(_body.velocity, 
						direction*SPEED,
						(ACCELERATION if direction else FRICTION)*_delta)
	_body.velocity = _velocity
	
	_body.move_and_slide()
	_body.global_position.x = clamp(_body.global_position.x, MIN_X, MAX_X)
	#_body.global_position.y = clamp(_body.global_position.y, MIN_Y, MAX_Y)
	get_parent().move_animation(direction)

func ToggleMovement(_can_move: bool):
	can_move = _can_move
