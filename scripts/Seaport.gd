extends Node2D
class_name Seaport

@export var EnterZone: Area2D
@export var _player: Player
@export var seaport_ui: PortUI
@export var seashop: ShopManager

@export var exit_location: Marker2D

@export var seashop_trader_boat: Boat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EnterZone.body_entered.connect(OnShopEntered)

func OnShopEntered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		EnterZone.set_deferred("monitoring", false)
		_player.shop_exit.connect(_on_player_exit)
		print("[Seaport]: Player entered area2d")
		_player.OnShopEntered()
		seaport_ui.MoveShopIntoView()
		seashop.LoadShop(_player, seashop_trader_boat)

func _on_player_exit()-> void:
	_player.shop_exit.disconnect(_on_player_exit)
	seaport_ui.MoveShopOutOfView()
	var target: Vector2 = Vector2(0, 72)
	await _player.OnShopExit(target, true, false)
	EnterZone.set_deferred("monitoring", true)
