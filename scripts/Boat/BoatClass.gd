extends CharacterBody2D

@export var sprite: Sprite2D

var boatType: String = "null"
var boatTier: String = "null"


var BOAT_PLACEHOLDER = sprite

func SpawnLoot():
	pass

func GenerateBoatVisual():
	match boatType:
		"null":
			pass

func OnSpawn(type: String, tier: String) -> void:
	boatType = type
	boatTier = tier
	position.y = 100
	SpawnLoot()
	GenerateBoatVisual()
