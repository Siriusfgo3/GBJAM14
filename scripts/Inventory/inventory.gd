extends Node
class_name Inventory

var slots: Array[InventorySlot]
@export var num_slots: int = 12

func _ready():
	InitializeSlots()

func add_item(new_item: Item, _amount: int) -> bool:
	for slot in slots:
		if slot.is_empty(): continue
		var _stack = slot.stack
		if _stack.item == new_item:
			_stack.amount += _amount
			slot.slot_changed.emit()
			return true
	for slot in slots:
		if slot.is_empty():
			slot.stack = ItemStack.new(new_item, _amount)
			slot.slot_changed.emit()
			return true
	return false
	
func can_accept(item: Item, amount: int) -> bool:
	for slot in slots:
		if not slot.is_empty() and slot.stack.item == item:
			return true
		if slot.is_empty():
			return true
	return false
	
func _is_empty() -> bool:
	for slot in slots:
		if not slot.is_empty(): return false
	return true
	
func receive_from(source: InventorySlot) -> bool:
	if source == null or source.is_empty():
		return false
	if not can_accept(source.stack.item, source.stack.amount):
		return false
	var stack := source.take_all()
	if add_item(stack.item, stack.amount):
		return true
	source.put(stack)  # should never run if can_accept matches add_item
	return false

func InitializeSlots():
	#Create num_slots InventorySlot and put them in slots. On each call slot.inventory = this
	slots.clear()
	for i in num_slots:
		slots.append(InventorySlot.new())
