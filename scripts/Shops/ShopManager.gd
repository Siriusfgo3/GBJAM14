extends Control
class_name ShopManager

var player_inventory: Inventory

@export var port: Port

@export var player_inventory_ui: InventoryUI

signal trade_completed(boatType: int)

var their_inventory: Inventory
@export var their_inventory_ui: InventoryUI

@export var player_scale_inventory: Inventory
@export var player_scale_inventory_ui: InventoryUI

@export var their_scale_inventory: Inventory
@export var their_scale_inventory_ui: InventoryUI

var _balancing := false

func _ready() -> void:
	#Bind scale inventories (they live on ShopUI)
	player_scale_inventory_ui.bind_inventory(player_scale_inventory)
	their_scale_inventory_ui.bind_inventory(their_scale_inventory)
	
	#Connect signals:
	player_inventory_ui.slot_pressed.connect(_on_my_item_pressed)
	their_inventory_ui.slot_pressed.connect(_on_their_item_pressed)
	player_scale_inventory_ui.slot_pressed.connect(_on_player_scale_item_pressed)
	their_scale_inventory_ui.slot_pressed.connect(_on_their_scale_item_pressed)
	player_scale_inventory.inventory_updated.connect(balance_trade)
	their_scale_inventory.inventory_updated.connect(balance_trade)
	

func LoadShop(player: Player, boat: Boat) -> void:
	player_inventory = player.get_inventory()
	player_inventory_ui.bind_inventory(player_inventory)
	
	if boat == null:
		return
	
	print("Filling boat inventory")
	their_inventory = boat.GetInventory()
	their_inventory_ui.bind_inventory(their_inventory)
	
	#Set focus:
	if their_inventory_ui.ui_slots.is_empty():
		return
	their_inventory_ui.ui_slots[0].button.call_deferred("grab_focus")

func _on_my_item_pressed(ui_slot: InventoryUISlot) -> void:
	_move_from_ui_to_inventory(ui_slot, player_scale_inventory)
	
func _on_their_item_pressed(ui_slot: InventoryUISlot) -> void:
	var slot := ui_slot.inventory_slot
	if slot.is_empty(): return
	var _stack_value = item_trade_value(slot.stack)
	if their_scale_inventory.coins + _stack_value > player_inventory.coins:
		print("Not enough money")
		return

	# Only charge the player if the item actually made it onto the scale.
	if not _move_from_ui_to_inventory(ui_slot, their_scale_inventory):
		return
	player_inventory.take_money(_stack_value)
	player_scale_inventory.add_money(_stack_value)
	
func _on_player_scale_item_pressed(ui_slot: InventoryUISlot) -> void:
	_move_from_ui_to_inventory(ui_slot, player_inventory)
	
func _on_their_scale_item_pressed(ui_slot: InventoryUISlot) -> void:
	var slot := ui_slot.inventory_slot
	if slot == null or slot.is_empty():
		return

	# Work out the refund before the stack leaves the slot.
	var _stack_value = item_trade_value(slot.stack)
	if not _move_from_ui_to_inventory(ui_slot, their_inventory):
		return
	player_scale_inventory.take_money(_stack_value)
	player_inventory.add_money(_stack_value)
	
func _move_from_ui_to_inventory(ui_slot: InventoryUISlot, dest: Inventory) -> bool:
	if dest == null:
		return false
	return dest.receive_from(ui_slot.inventory_slot)

func item_trade_value(item_stack: ItemStack) -> int:
	var _item_type = item_stack.item.item_type
	var _item_amount = item_stack.amount
	var _stack_value = (_item_amount * item_stack.item.basevalue)
	return _stack_value

func balance_trade() -> void:
	if _balancing:
		return
	_balancing = true

	var target := port.active_boat.evaluate_inventory(player_scale_inventory)

	var delta := target - their_scale_inventory.coins
	if delta != 0:
		their_scale_inventory.add_money(delta)

	_balancing = false
	
func GetInventoryValue(_inventory: Inventory) -> float:
	var _value := 0.0
	for slot in _inventory.slots:
		if slot.is_empty(): continue
		var _stack := slot.stack
		if _stack:
			_value += _stack.item.basevalue * _stack.amount
	return _value
	
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
