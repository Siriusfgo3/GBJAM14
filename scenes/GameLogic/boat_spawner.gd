extends Node

@export var spawnLocation:Vector2 
@export var gameControler: Node
var boatTables: Array = [
	[0,0,0,0],
	[0,0,0,0],
	[0,0,0,0],
	[0,0,0,0]
]

var lootTables: Array = [
	[0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0]
]

var boatSpawnRates: Array= [1.0,1.0,1.0,0]

var lootLookup = [
	# Imperial
	[
		"res://resources/inventory/Items/log.tres",
		"res://resources/inventory/Items/gunpowder.tres",
		"res://resources/inventory/Items/Ivory.tres",
		"Amulet",
		"Indigo Powder",
		"Imperial Shields",
		"res://resources/inventory/Items/Rock.tres",
		"res://resources/inventory/Items/Rock.tres",
		"res://resources/inventory/Items/Rock.tres",
		"res://resources/inventory/Items/Rock.tres"
	],

	# Oriental
	[
		"res://resources/inventory/Items/chicken_feet.tres",
		"res://resources/inventory/Items/paper.tres",
		"res://resources/inventory/Items/tea.tres",
		"Winged Armor",
		"res://resources/inventory/Items/FancyLantern.tres",
		"Silk",
		"res://resources/inventory/Items/Rock.tres",
		"res://resources/inventory/Items/Rock.tres",
		"res://resources/inventory/Items/Rock.tres",
		"res://resources/inventory/Items/Rock.tres"
	],

	# Seafolk
	[
		"res://resources/inventory/Items/seaweed.tres",
		"res://resources/inventory/Items/harpoon_heads.tres",
		"res://resources/inventory/Items/whale_blood.tres",
		"Seapig Armor",
		"Seapearl",
		"Clam Necklace",
		"res://resources/inventory/Items/Rock.tres",
		"res://resources/inventory/Items/Rock.tres",
		"res://resources/inventory/Items/Rock.tres",
		"res://resources/inventory/Items/Rock.tres"
	],

	# Pirate
	[
		"Rum",
		"Eyeballs",
		"Treasure Maps",
		"Axehead Armor",
		"res://resources/inventory/Items/Rock.tres",
		"res://resources/inventory/Items/Rock.tres",
		"res://resources/inventory/Items/Rock.tres",
		"res://resources/inventory/Items/Rock.tres",
		"res://resources/inventory/Items/Rock.tres",
		"res://resources/inventory/Items/Rock.tres"
	]
]

func weighted_probabilty(probabilty_container:Array):
	var container_total = 0.0
	
	for i in probabilty_container:
		container_total += i
		
	var roll: float = randf() * container_total
	
	var container_iter = 0.0
	for i in range(probabilty_container.size()):
		container_iter += probabilty_container[i]
		if roll <= container_iter:
			return i
		
	return probabilty_container.size() - 1

func spawn_boat() -> void:
	
	var boatType = weighted_probabilty(boatSpawnRates)
	var boatTier = weighted_probabilty(boatTables[boatType])
	var path = "res://scenes/boatTypes/%d/type_%d_tier_%d_boat.tscn" % [
	boatType,
	boatType,
	boatTier
	]
	if not ResourceLoader.exists(path):
		push_error("Boat scene does not exist:" + path)
		return
		
	var scene := load(path) as PackedScene
	var boat := scene.instantiate()

	
	get_parent().add_child(boat)
	boat.global_position = spawnLocation
	load_boat(boatType, boatTier, boat)


func load_boat(boatType:int, boatTier:int, boat:Boat):
	var loot:Array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	var number_of_items = ((boatTier + 1 ) * (boatTier + 1)) * ceil(gameControler.favor[boatType])
	for i in range(number_of_items):
		var _item = weighted_probabilty(lootTables[boatType])
		loot[_item] += 1
	
	for i in range(loot.size()):
		if loot[i] <= 0: continue
		var _item_path = lootLookup[boatType][i] 
		if not ResourceLoader.exists(_item_path):
			push_warning("Missing loot item resource, skipping" + str(_item_path))
			continue
		var _item = load(_item_path)
		boat.loadItem(_item, loot[i])
	
