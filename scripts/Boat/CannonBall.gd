extends EnemyProjectile

@export var height: int = 12

func path_offset(t: float) -> Vector2:
	return Vector2(0, -height * 4.0 * t * (1.0 - t))
