extends Control
class_name InventoryUI

var ui_slots: Array[InventoryUISlot]

@export var coinStack: CoinStack

var binded_inventory: Inventory

signal slot_pressed(ui_slot: InventoryUISlot)

func _ready() -> void:
	ui_slots.clear()
	for node in find_children("*", "InventoryUISlot", true, false):
		ui_slots.append(node)

func bind_inventory(inventory: Inventory) -> void:
	for i in mini(inventory.slots.size(), ui_slots.size()):
		ui_slots[i].bind_slot(inventory.slots[i])
		if not ui_slots[i].was_pressed.is_connected(_on_ui_slot_pressed):
			ui_slots[i].was_pressed.connect(_on_ui_slot_pressed)

	if binded_inventory != null and binded_inventory.money_changed.is_connected(OnInventoryMoneyChanged):
		binded_inventory.money_changed.disconnect(OnInventoryMoneyChanged)
	binded_inventory = inventory
	if binded_inventory:
		binded_inventory.money_changed.connect(OnInventoryMoneyChanged)
		OnInventoryMoneyChanged()  # show current coins immediately

func _on_ui_slot_pressed(ui_slot: InventoryUISlot) -> void:
	slot_pressed.emit(ui_slot)
	
func OnInventoryMoneyChanged() -> void:
	if coinStack == null: return
	coinStack.coins(binded_inventory.coins)
	print("Added money to inventory UI")
