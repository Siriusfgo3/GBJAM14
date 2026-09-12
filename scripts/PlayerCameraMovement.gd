extends Node

@export var _body: CharacterBody2D
@export var MIN_X: int = 0
@export var MAX_X: int = 1280 - GlobalVariables.CAMERA_WIDTH
@export var SPEED: float = 200

func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	_body.velocity.x = direction * SPEED

	_body.move_and_slide()
	_body.position.x = clamp(_body.position.x, MIN_X, MAX_X)
