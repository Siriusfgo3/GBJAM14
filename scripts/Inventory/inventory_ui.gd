extends Control
class_name InventoryUI

@export var ui_slots: Array[InventoryUISlot]

func bind_inventory(inventory: Inventory) -> void:
	for i in mini(inventory.slots.size(), ui_slots.size()):
		ui_slots[i].bind_slot(inventory.slots[i])
	
