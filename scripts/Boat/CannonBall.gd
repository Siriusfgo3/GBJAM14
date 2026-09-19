extends EnemyProjectile

@export var height: int = 12

func path_offset(t: float) -> Vector2:
	return Vector2(0, -height * 4.0 * t * (1.0 - t))
	
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	var _player = body as Player
	if _player:
		_player.GetHit()
		queue_free()
		
