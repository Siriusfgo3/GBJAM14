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
			
	for slot in slots:
		if slot.is_empty():
			slot.stack = ItemStack.new(new_item, _amount)
			print("Added" + str(_amount) + str(new_item.name))
			slot.slot_changed.emit()
			return true
	return false

func InitializeSlots():
	#Create num_slots InventorySlot and put them in slots. On each call slot.inventory = this
	slots.clear()
	for i in num_slots:
		slots.append(InventorySlot.new())
