extends CharacterBody2D
class_name Boat 

@export var sprite: Sprite2D
@export var inventory: Inventory

@export var boatType: int
@export var boatTier: int 
var allMastsAreDown: bool

@export var boat_length: int = 16

@export var boat_movement: BoatMovement

func loadItem(item:Item, amount:int):
	inventory.add_item(item, amount)

func _process(delta: float):
	if allMastsAreDown:
		if Input.is_action_just_pressed("button_a"):
			queue_free()

func GetInventory() -> Inventory:
	return inventory

func EnterQueue():
	print("Boat entered queueu")
	boat_movement.speed = 10
	collision_mask |= 1 << 2
	
func SailToX(target: int) -> void:
	print("[Boat]: Setting target x")
	boat_movement.set_target(target)
