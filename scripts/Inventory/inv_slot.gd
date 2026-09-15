extends RefCounted
class_name InventorySlot

signal slot_changed

var stack: ItemStack = null

func is_empty() -> bool:
	return stack == null

func take(take_amount: int) -> ItemStack:
	if is_empty() or take_amount > stack.amount:
		return null
	
	var given_stack = ItemStack.new(stack.item, take_amount)
	
	stack.amount -= take_amount
	
	if stack.amount <= 0:
		clear()
	
	slot_changed.emit()
	return given_stack

func take_all() -> ItemStack:
	if is_empty():
		return null
	
	var given_stack = stack
	clear()
	return given_stack

func clear() -> void:
	stack = null
	slot_changed.emit()
