extends RefCounted
class_name ItemStack

var item: Item
var amount: int = 0

func _init(_item: Item, _amount: int = 1) -> void:
	item = _item
	amount = _amount
