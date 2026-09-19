extends Node
class_name Inventory

var slots: Array[InventorySlot]
@export var num_slots: int = 12

var coins: float = 0

var item_weights: Array = [
	[1.0, 1.0, 1.0],
	[1.0, 1.0, 1.0],
	[1.0, 1.0, 1.0],
	[1.0, 1.0, 1.0]
	]

signal inventory_updated
signal money_changed

func _ready():
	InitializeSlots()

func add_item(new_item: Item, _amount: int) -> bool:
	for slot in slots:
		if slot.is_empty(): continue
		var _stack = slot.stack
		if _stack.item == new_item:
			_stack.amount += _amount
			slot.slot_changed.emit()
			inventory_updated.emit()
			return true
	for slot in slots:
		if slot.is_empty():
			slot.stack = ItemStack.new(new_item, _amount)
			slot.slot_changed.emit()
			inventory_updated.emit()
			return true
	return false
	
func add_money(money: float) -> void:
	if money == 0:
		return
	coins += money
	inventory_updated.emit()
	money_changed.emit()
	
func take_money(money: float) -> void:
	coins -= money
	inventory_updated.emit()
	money_changed.emit()
	
func empty_coffers() -> void:
	coins = 0
	inventory_updated.emit()
	money_changed.emit()

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
