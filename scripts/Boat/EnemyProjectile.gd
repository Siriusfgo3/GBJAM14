class_name EnemyProjectile
extends Area2D

var start: Vector2
var target: Vector2
var t: float = 0.0
@export var flight_time: float = 0.6
var t_max: float = 2.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	t = minf(t+delta / flight_time, t_max)
	global_position = start.lerp(target, t) + path_offset(t)
	if t >= t_max:
		queue_free()

func path_offset(t: float):
	return Vector2.ZERO
	
func initiate_path(_start: Vector2, _target: Vector2):
	start = _start
	target = _target
	t = 0.0
	global_position = start
