extends Area2D
class_name WorldItem

enum LocomotionState {
	FALLING,
	FLOATING
}

var current_state: LocomotionState = LocomotionState.FALLING

@export var sprite: Sprite2D
var item_resource: Item
var amount: int = 1

var _velocity := Vector2.ZERO
@export var _gravity: int = 400
@export var settle_y: int = 120

var float_time: float = 0
var float_phase: float = 3.14
@export var float_amplitude: int = 5
@export var float_freq: float = 0.6

func setup(_item: Item, _amount: int) -> void:
	if _item == null: return
	item_resource = _item
	amount = _amount
	sprite.texture = item_resource.texture

func _physics_process(delta: float) -> void:
	match current_state:
		LocomotionState.FALLING:
			_velocity.y += _gravity * delta
			global_position += _velocity * delta
			if global_position.y >= settle_y:
				_velocity = Vector2.ZERO
				global_position.y = settle_y
				current_state = LocomotionState.FLOATING
		LocomotionState.FLOATING:
			float_time += delta
			global_position.y = settle_y + sin(float_time * float_freq + float_phase)
		
