extends Node

@export var boatSpawner: BoatSpawner
@export var oceanTimer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	oceanTimer.one_shot = true
	oceanTimer.timeout.connect(_on_timeout)
	_on_timeout()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_timeout() -> void:
	boatSpawner.SpawnBoat("null", "null")
