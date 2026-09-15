extends CharacterBody2D
class_name Boat 

@export var sprite: Sprite2D
@export var inventory: Inventory

@export var boatType: int
@export var boatTier: int 
var allMastsAreDown: bool

func loadItem (item:Item, amount:int):
	inventory.add_item(item, amount)

func _process(delta: float):
	if allMastsAreDown:
		if Input.is_action_just_pressed("button_a"):
			queue_free()
