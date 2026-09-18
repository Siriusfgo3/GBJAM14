extends Control
class_name ShopManager

var player_inventory: Inventory


@export var port:Port

@export var player_inventory_ui: InventoryUI

signal trade_completed(boatType: int)

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
	

func LoadShop(player: Player, boat: Boat) -> void:
	player_inventory = player.get_inventory()
	player_inventory_ui.bind_inventory(player_inventory)
	
	if boat == null:
		return
	
	print("Filling boat inventory")
	their_inventory = boat.GetInventory()
	their_inventory_ui.bind_inventory(their_inventory)

func _on_my_item_pressed(ui_slot: InventoryUISlot) -> void:
	_move_from_ui_to_inventory(ui_slot, player_scale_inventory)
	
func _on_their_item_pressed(ui_slot: InventoryUISlot) -> void:
	if trade_possible(ui_slot.inventory_slot.stack):
		_move_from_ui_to_inventory(ui_slot, their_scale_inventory)
	else : print("Not enought money")
func _on_player_scale_item_pressed(ui_slot: InventoryUISlot) -> void:
	_move_from_ui_to_inventory(ui_slot, player_inventory)
	
func _on_their_scale_item_pressed(ui_slot: InventoryUISlot) -> void:
	_move_from_ui_to_inventory(ui_slot, their_inventory)
	
func _move_from_ui_to_inventory(ui_slot: InventoryUISlot, dest: Inventory) -> void:
	if dest == null:
		return
	dest.receive_from(ui_slot.inventory_slot)

func trade_possible(item_stack: ItemStack) -> bool:
	var _item_type = item_stack.item.item_type
	var _item_amount = item_stack.amount
	var _stack_value = (_item_amount * item_stack.item.basevalue)
	return their_scale_inventory.coins + _stack_value <= player_inventory.coins
	
func balance_trade() -> void:
	var diff:int = their_scale_inventory.coins - port.active_boat.evaluate_inventory(player_scale_inventory)
	if diff <= 0:
		their_scale_inventory.add_money(diff)
	elif player_inventory.coins >= diff:
		player_inventory.take_money(diff)
		player_scale_inventory.add_money(diff)
	return
	
func _on_trade_button_pressed() -> void:
	#TO-DO MOVE MONEY AS WELL + CHECK TRADE VALIDITY
	for their_scale_slot in their_scale_inventory_ui.ui_slots:
		_move_from_ui_to_inventory(their_scale_slot, player_inventory)
	for player_scale_slot in player_scale_inventory_ui.ui_slots:
		_move_from_ui_to_inventory(player_scale_slot, their_inventory)
	player_inventory.add_money(their_scale_inventory.coins)
	player_scale_inventory.empty_coffers()
	their_scale_inventory.empty_coffers()
	
	
func take_stack_from_ui_slot(ui_slot: InventoryUISlot) -> ItemStack:
	var source_slot := ui_slot.inventory_slot
	if source_slot == null or source_slot.is_empty():
		return null
	return source_slot.take_all()
