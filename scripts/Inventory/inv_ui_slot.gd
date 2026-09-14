extends Control
class_name InventoryUISlot

@export var texture_rect: TextureRect
@export var amount_label: Label

var inventory_slot: InventorySlot = null

func bind_slot(new_slot: InventorySlot) -> void:
	if inventory_slot and inventory_slot.slot_changed.is_connected(_on_slot_changed):
		inventory_slot.slot_changed.disconnect(_on_slot_changed)
	inventory_slot = new_slot
	if inventory_slot:
		inventory_slot.slot_changed.connect(_on_slot_changed)
	_on_slot_changed()
	
func _on_slot_changed():
	if inventory_slot.stack == null:
		clear()
		return
	texture_rect.texture = inventory_slot.stack.item.texture
	amount_label.text = str(inventory_slot.stack.amount)

func clear():
	amount_label.text = ""
	texture_rect.texture = null
