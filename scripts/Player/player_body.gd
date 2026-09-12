extends CharacterBody2D

@onready var inv: Inv = preload("res://resources/inventory/Inventories/player_inventory.tres")

func collect(item):
	inv.insert(item)
