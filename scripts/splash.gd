extends GPUParticles2D

@export var HEIGHT: int = 8
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position.y = 144 - HEIGHT # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_position.y = 144 - HEIGHT
