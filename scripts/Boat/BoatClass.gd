extends CharacterBody2D
class_name Boat 

@export var sprite: Sprite2D
@export var inventory: Inventory

@export var boatType: int
@export var boatTier: int 
var allMastsAreDown: bool

signal boat_dead(boat: Boat)

@export var boat_length: int = 16

@export var boat_movement: BoatMovement
@export var world_item_scene: PackedScene

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

func TakeHit() -> void:
	if allMastsAreDown:
		Die()
	else:
		pass

func Die() -> void:
	if not is_inside_tree():
		return
	drop_items()
	boat_dead.emit(self)
	queue_free()

func drop_items() -> void:
	var world := get_parent()
	for slot in inventory.slots:
		if slot.is_empty():
			continue
		var stack: ItemStack = slot.take_all()
		var worldItem := world_item_scene.instantiate() as WorldItem
		world.add_child(worldItem)
		worldItem.global_position = global_position
		worldItem.setup(stack.item, stack.amount)
		worldItem._velocity = Vector2(randf_range(-60, 60), randf_range(-180, -80))
