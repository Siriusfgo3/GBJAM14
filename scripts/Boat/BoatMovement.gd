extends Node
class_name BoatMovement

@export var speed: float = 25.0
var direction: int = 1

@export var min_dt: float = 1
@export var max_dt: float = 3

@export var _body: CharacterBody2D


var target_x: int = GlobalVariables.OCEAN_WIDTH * 2

# Called when the node enters the scene tree for the first time.

func _on_timeout() -> void:
	#direction *= -1
	_body.velocity.x = direction * speed
	
func _physics_process(_delta: float) -> void:
	if _body.global_position.x > target_x:
		_body.velocity.x = 0
		return
	elif _body.velocity.x < 1:
		_body.velocity.x = direction * speed
	_body.move_and_slide()
	
func set_target(new_target: int) -> void:
	target_x = new_target
	
