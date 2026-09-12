extends Node

@export var port: Port
@export var port_ui: PortUI
@export var sea_trade_ui: Control
@export var player_state: Node

@export var boatSpawner: BoatSpawner
@export var oceanTimer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	port.port_entered.connect(_on_port_entered)
	port.port_exited.connect(_on_port_exited)
	
	oceanTimer.one_shot = true
	oceanTimer.timeout.connect(_on_timeout)
	_on_timeout()

func _on_port_entered() -> void:
	#player_state.change_state(player_state.PlayerState.TRADING)
	port_ui.EnableTransition()
	
func _on_port_exited() -> void:
	port_ui.DisableTransition()
	
func _on_timeout() -> void:
	boatSpawner.SpawnBoat("null", "null")
