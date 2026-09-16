extends Node

var favor: Array[float] = [1.5, 1.5, 1.5, 1.5]

var progression: float = 0

@onready var spawnTimer: Timer = $spawnTimer
#@export var boat_scene: PackedScene
@onready var boatSpawner: Node = $boatSpawner

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

func generateLootTable(lootTables:Array) -> Array:
	for j in range(4):
		for i in range(10):
			boatSpawner.lootTables[j][i] = snapped(expCdf(i+1,i,favor[j]) + (expCdf(1000,10,favor[j]))/10,0.001)
	return lootTables

func convertedProgression():
	return 3 * (1 - progression/1000) + 0.1 * progression/1000

func generateBoatTable(boatTables: Array) -> Array:
	
	for j in range(4):
		for i in range(4):
			boatSpawner.boatTables[j][i] = snapped(gamma2Cdf(i+1,i,convertedProgression())+gamma2Cdf(1000,4,convertedProgression())/4,0.001)
	return boatTables


func _on_spawnTimer_timeout():
	boatSpawner.spawn_boat()
	pass
	
func _ready():
	spawnTimer.timeout.connect(_on_spawnTimer_timeout)
	generateLootTable(boatSpawner.lootTables)
	print(boatSpawner.lootTables)
	generateBoatTable(boatSpawner.boatTables)
	print(boatSpawner.boatTables)
	
func update_favor(): pass
