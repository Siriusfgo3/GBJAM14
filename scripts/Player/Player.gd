extends CharacterBody2D
class_name Player

@export var player_inventory: Inventory

func get_inventory() -> Inventory:
	return player_inventory
