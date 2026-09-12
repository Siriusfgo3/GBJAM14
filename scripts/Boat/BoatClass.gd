extends CharacterBody2D

@export var sprite: Sprite2D

var boatType: String = "null"
var boatTier: String = "null"


var BOAT_PLACEHOLDER = sprite

func SpawnLoot():
	pass

func GenerateBoatVisual():
	print("Matching boat type")
	match boatType:
		"null":
			print("Setting texture")
			sprite.texture = BOAT_PLACEHOLDER

func OnSpawn(type: String, tier: String) -> void:
	print("Boat Spawned")
	boatType = type
	boatTier = tier
	position.y = 100
	SpawnLoot()
	GenerateBoatVisual()
