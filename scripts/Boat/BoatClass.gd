extends CharacterBody2D
class_name Boat 

@export var sprite: Sprite2D
@export var inventory: Inventory

@export var boatType: int
@export var boatTier: int 
var allMastsAreDown: bool

signal boat_dead(boat: Boat)



@export var boat_movement: BoatMovement
@export var world_item_scene: PackedScene
@export var docked_z_index: int = -4
var is_docked: bool = false
var _sailing_z_index: int = -2
var _sailing_z_as_relative: bool = true

@onready var mast_container = get_node_or_null("Mast_container")
@onready var BoatFront = $BoatFront
@onready var BoatEnd = $BoatEnd
@onready var boat_length = BoatFront.position.x - BoatEnd.position.x
var item_type_weights:Array =[
	[1.0, 1.0, 1.0],
	[1.0, 1.0, 1.0],
	[1.0, 1.0, 1.0],
	[1.0, 1.0, 1.0]
	]

func evaluate_inventory(_inventory:Inventory) -> float:
	var inventory_value: float = 0 
	for slot in _inventory.slots:
		if slot.is_empty(): continue
		var _stack = slot.stack
		inventory_value += _stack.amount * _stack.item.basevalue * item_type_weights[boatType][_stack.item.item_type]
	return inventory_value
	

func loadItem(item:Item, amount:int):
	inventory.add_item(item, amount)

func GetInventory() -> Inventory:
	return inventory

func EnterQueue():
<<<<<<< HEAD
=======
	#print("Boat entered queueu")
>>>>>>> 1479a797416657f8037896938a25e699435abb40
	boat_movement.speed = 10
	collision_mask |= 1 << 2
	
func SailToX(target: int) -> void:
<<<<<<< HEAD
=======
	#print("[Boat]: Setting target x")
>>>>>>> 1479a797416657f8037896938a25e699435abb40
	boat_movement.set_target(target)
	
func SetDocked(docked: bool) -> void:
	if is_docked == docked:
		return
	is_docked = docked
	
	if docked:
		_sailing_z_index = z_index
		_sailing_z_as_relative = z_as_relative
		z_as_relative = false
		z_index = docked_z_index
	else:
		z_index = _sailing_z_index
		z_as_relative = _sailing_z_as_relative

	if mast_container:
		mast_container.SetMastsDamageable(not docked)

func TakeHit() -> void:
	if allMastsAreDown:
		Die.call_deferred()
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
