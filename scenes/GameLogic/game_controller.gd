extends Node


var favor: Array[float] = [1.5, 1.5, 1.5, 1.5]
var boatSpawnRates: Array[float] = [1,0,0,0]
var progression: float = 0

@onready var spawnTimer: Timer = $spawnTimer
#@export var boat_scene: PackedScene

var SPAWN_POSITION: int = -50

var lootTables: Array = [
	[0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0]
]

var lootLookup = [
	# Imperial
	[
		("res://resources/inventory/Items/log.tres"),
		"Gunpowder",
		"Ivory",
		"Amulet",
		"Indigo Powder",
        "Imperial Shields"
	],

	# Oriental
	[
		"Chicken Feet",
		"Paper",
		"Tea",
		"Winged Armor",
		"Fancy Lantern",
        "Silk"
	],

	# Seafolk
	[
		"Seaweed",
		"Harpoon Heads",
		"Whale Blood",
		"Seapig Armor",
		"Seapearl",
        "Clam Necklace"
	],

	# Pirate
	[
		"Rum",
		"Eyeballs",
		"Treasure Maps",
        "Axehead Armor"
	]
]

var boatTables: Array = [
	[0,0,0,0],
	[0,0,0,0],
	[0,0,0,0],
	[0,0,0,0]
]

func expCdf(x: float, y:float, lambda: float) -> float:
	if x <0.0 or y<0.0:
		return 0
	if y > x:
		print("Error")
		
	return (1.0-exp(-lambda * x)) - (1.0-exp(-lambda * y))

func gamma2Cdf(x: float, y:float, lambda: float) -> float:
	if x <0.0 or y<0.0:
		return 0
	if y > x:
		print("Error")
		
	return (1.0 - exp(-lambda * x) * (1+lambda * x)) - (1.0 - exp(-lambda * y) * (1+lambda * y))

func weighted_probabilty(container:Array):
	var container_total = 0.0
	
	for i in container:
		container_total += container[i]
		
	var roll: float = randf() * container_total
	
	var container_iter = 0.0
	for i in container:
		container_iter += container[i]
		if roll <= container_iter:
			return i
		else:
			return container.size()

func generateLootTable(lootTables:Array) -> Array:
	
	for j in range(4):
		for i in range(10):
			lootTables[j][i] = snapped(expCdf(i+1,i,favor[j]) + (expCdf(1000,10,favor[j]))/10,0.001)
	return lootTables

func convertedProgression():
	return 3 * (1 - progression/1000) + 0.1 * progression/1000

func generateBoatTable(boatTables: Array) -> Array:
	
	for j in range(4):
		for i in range(4):
			boatTables[j][i] = snapped(gamma2Cdf(i+1,i,convertedProgression())+gamma2Cdf(1000,4,convertedProgression())/4,0.001)
	return boatTables

func getItemPath(boatType: int):
	var loot: int = weighted_probabilty(lootTables[boatType])
	return lootLookup[loot]

func SpawnBoat() -> void:
	var boatType = weighted_probabilty(boatSpawnRates)
	var boatTier = weighted_probabilty(boatTables[boatType])
	var path = "res://scenes/boatTypes/%d/%s" % [boatType, boatTier]
	if not ResourceLoader.exists(path):
		push_error("Enemy scene does not exist:" + path)
	var scene := load(path) as PackedScene
	var boat := scene.instantiate()
	boat.global_position.x = SPAWN_POSITION
	get_parent().add_child.call_deferred(boat)
	var item: InvItem = load(getItemPath(boatType))
	boat.inventory.insert(item)
	
	

func _on_spawnTimer_timeout():
	SpawnBoat()

func _ready():
	spawnTimer.timeout.connect(_on_spawnTimer_timeout)
	generateLootTable(lootTables)
	print(lootTables)
	generateBoatTable(boatTables)
	print(boatTables)
	
