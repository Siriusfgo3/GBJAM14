extends Node

#FOR _TESTING:
@export var player: Player
@export var boat: Boat
@export var item1: Item
@export var item2: Item
@export var item3: Item

var player_inventory: Inventory
@export var player_inventory_ui: InventoryUI

var their_inventory: Inventory
@export var their_inventory_ui: InventoryUI

@export var player_scale_inventory: Inventory
@export var player_scale_inventory_ui: InventoryUI

@export var their_scale_inventory: Inventory
@export var their_scale_inventory_ui: InventoryUI

func _ready() -> void:
	#Bind scale inventories (they live on ShopUI)
	player_scale_inventory_ui.bind_inventory(player_scale_inventory)
	their_scale_inventory_ui.bind_inventory(their_scale_inventory)
	
	#Connect signals:
	player_inventory_ui.slot_pressed.connect(_on_my_item_pressed)
	their_inventory_ui.slot_pressed.connect(_on_their_item_pressed)
	player_scale_inventory_ui.slot_pressed.connect(_on_player_scale_item_pressed)
	their_scale_inventory_ui.slot_pressed.connect(_on_their_scale_item_pressed)
	
	call_deferred("_TESTING")
	
func _TESTING():
	var playe_inv = player.get_inventory()
	playe_inv.add_item(item1, 4)
	playe_inv.add_item(item2, 7)
	playe_inv.add_item(item3, 21)
	var boat_inv = boat.GetInventory()
	boat_inv.add_item(item1, 23)
	boat_inv.add_item(item2, 74)
	boat_inv.add_item(item3, 46)
	OpenShop(player, boat)

func OpenShop(player: Player, boat: Boat) -> void:
	player_inventory = player.get_inventory()
	player_inventory_ui.bind_inventory(player_inventory)
	
	their_inventory = boat.GetInventory()
	their_inventory_ui.bind_inventory(their_inventory)	

func _on_my_item_pressed(ui_slot: InventoryUISlot) -> void:
	_move_from_ui_to_inventory(ui_slot, player_scale_inventory)
	
func _on_their_item_pressed(ui_slot: InventoryUISlot) -> void:
	_move_from_ui_to_inventory(ui_slot, their_scale_inventory)
	
func _on_player_scale_item_pressed(ui_slot: InventoryUISlot) -> void:
	_move_from_ui_to_inventory(ui_slot, player_inventory)
	
func _on_their_scale_item_pressed(ui_slot: InventoryUISlot) -> void:
	_move_from_ui_to_inventory(ui_slot, their_inventory)
	
func _move_from_ui_to_inventory(ui_slot: InventoryUISlot, dest: Inventory) -> void:
	if dest == null:
		return
	dest.receive_from(ui_slot.inventory_slot)
	
func take_stack_from_ui_slot(ui_slot: InventoryUISlot) -> ItemStack:
	var source_slot := ui_slot.inventory_slot
	if source_slot == null or source_slot.is_empty():
		return null
	return source_slot.take_all()
