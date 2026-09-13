extends Node

var favor: Array[float] = [1.5, 1.5, 1.5, 1.5]
var maxFavor: float = 0

var lootTables: Array = [
	[0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0]
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



func generateLootTable(lootTables:Array) -> Array:
	
	for j in range(4):
		for i in range(10):
			lootTables[j][i] = snapped(expCdf(i+1,i,favor[j]) + (expCdf(1000,10,favor[j]))/10,0.001)
	return lootTables


func generateBoatTable(boatTables: Array) -> Array:
	
	for j in range(4):
		for i in range(4):
			boatTables[j][i] = expCdf(4*(i+1),4*i,1-maxFavor) + (expCdf(1000,16,1-maxFavor))/4
	
	return boatTables

func _ready():
	generateLootTable(lootTables)
	print(lootTables)
	generateBoatTable(boatTables)
	print(boatTables)
	maxFavor=0.8
	generateBoatTable(boatTables)
	print(boatTables)
	
