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

var boatSpawnRates: Array= [1.0,0,0,0]

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
		"Chicken Feet",
		"Paper",
		"Tea",
		"Winged Armor",
		"Fancy Lantern",
		"Silk",
		"res://resources/inventory/Items/Rock.tres",
		"res://resources/inventory/Items/Rock.tres",
		"res://resources/inventory/Items/Rock.tres",
		"res://resources/inventory/Items/Rock.tres"
	],

	# Seafolk
	[
		"Seaweed",
		"Harpoon Heads",
		"Whale Blood",
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
		"Rock",
		"Rock",
		"Rock",
		"Rock",
		"Rock",
		"Rock"
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
	var number_of_items = ((boatTier +1 ) * (boatTier +1)) * ceil(gameControler.favor[boatType])
	for i in range(number_of_items):
		var _item = weighted_probabilty(lootTables[boatType])
		loot[_item] += 1
	
	for i in range(loot.size()):
		if loot[i] <= 0: continue
		var _item = load(lootLookup[boatType][i]) 
		boat.loadItem(_item, loot[i])
	
