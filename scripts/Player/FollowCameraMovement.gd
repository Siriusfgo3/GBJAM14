extends Node2D

@export var follow_target: Node2D

@export var MIN_X: int = GlobalVariables.CAMERA_WIDTH / 2
@export var MAX_X: int = GlobalVariables.OCEAN_WIDTH - GlobalVariables.CAMERA_WIDTH / 2

var MIN_Y: int = GlobalVariables.CAMERA_HEIGHT / 2
var MAX_Y: int = GlobalVariables.OCEAN_HEIGHT - GlobalVariables.CAMERA_HEIGHT / 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position.x = follow_target.global_position.x
	global_position.x = clamp(global_position.x, MIN_X, MAX_X)
	
	global_position.y = follow_target.global_position.y - GlobalVariables.CAMERA_HEIGHT / 2
	global_position.y = clamp(global_position.y, MIN_Y, MAX_Y)
	
