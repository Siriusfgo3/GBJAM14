extends Control
class_name InventoryUI

@export var ui_slots: Array[InventoryUISlot]

signal slot_pressed(ui_slot: InventoryUISlot)

func bind_inventory(inventory: Inventory) -> void:
	for i in mini(inventory.slots.size(), ui_slots.size()):
		ui_slots[i].bind_slot(inventory.slots[i])
		if not ui_slots[i].was_pressed.is_connected(_on_ui_slot_pressed):
			ui_slots[i].was_pressed.connect(_on_ui_slot_pressed)

func _on_ui_slot_pressed(ui_slot: InventoryUISlot) -> void:
	slot_pressed.emit(ui_slot)
