extends Node2D
class_name Port

signal player_entered_pier_zone
signal player_entered_shop

@export var _player: Player

@export var shop: ShopManager

@export var port_ui: PortUI

@export var exit_location: Marker2D

@export var PierZone: Area2D
@export var EnterShopZone: Area2D

@export var max_queue_length: int = 400
@export var queue_start_marker: Marker2D
@export var queue_spacing: int = 6
var current_queue_spot: int = 0

@export var max_queue_spots: int = 5
var boat_queue: Array[Boat] = []
var active_boat: Boat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PierZone.body_entered.connect(OnPierZoneEntered)
	EnterShopZone.body_entered.connect(OnShopEntered)

func OnShopEntered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		EnterShopZone.set_deferred("monitoring", false)
		_player.shop_exit.connect(_on_player_exit)
		_player.OnShopEntered()
		port_ui.MoveShopIntoView()
		#player_entered_shop.emit()
		if active_boat == null:
			active_boat = next_boat_from_queue()
		if active_boat != null:
			shop.LoadShop(_player, active_boat.GetInventory())

func OnPierZoneEntered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_entered_pier_zone.emit()
	if body.is_in_group("Boat"):
		var _boat = body as Boat
		var _boatLen = _boat.boat_length
		current_queue_spot += _boatLen + queue_spacing
		var boat_queue_pos = queue_start_marker.global_position.x - current_queue_spot
		if PortFull():
			print("Boat rejected: port full")
			return #Port is FULL
		
		_boat.SailToX(boat_queue_pos)
		_boat.boat_dead.connect(_onBoatKill)
		boat_queue.push_back(body)

func _onBoatKill(boat: Boat)-> void:
	boat_queue.erase(boat)

func _on_player_exit()-> void:
	_player.shop_exit.disconnect(_on_player_exit)
	port_ui.MoveShopOutOfView()
	var target: Vector2 = Vector2(global_position.x - 100, 0)
	_dismiss_active_boat()
	await _player.OnShopExit(target, false, true)
	EnterShopZone.set_deferred("monitoring", true)
	
func _dismiss_active_boat() -> void:
	if active_boat != null:
		active_boat.SailToX(GlobalVariables.OCEAN_WIDTH * 2)
		active_boat = null
	_advance_queue()
	
func _advance_queue() -> void:
	current_queue_spot = 0
	for boat in boat_queue:
		current_queue_spot += boat.boat_length + queue_spacing
		boat.SailToX(queue_start_marker.global_position.x - current_queue_spot)

func next_boat_from_queue() -> Boat:
	if boat_queue.is_empty():
		return null
	return boat_queue.pop_front()

func PortFull() -> bool:
	return boat_queue.size() >= max_queue_spots
