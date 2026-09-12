extends Node

enum PlayerState {
	SWIMMING,
	TRADING,
	INVENTORY,
	PAUSED,
}

var current_state: PlayerState = PlayerState.SWIMMING

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func change_state(new_state: PlayerState):
	if current_state == new_state:
		return
	pass
	
func enter_state(state: PlayerState):
	pass

func exit_state(state: PlayerState):
	pass
