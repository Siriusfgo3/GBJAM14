extends Node

@export var player_inventory: Inventory
@export var item: Item
@export var item2: Item
@export var inventory_ui: InventoryUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventory_ui.bind_inventory(player_inventory)
	player_inventory.add_item(item, 42)
	player_inventory.add_item(item2, 18)
