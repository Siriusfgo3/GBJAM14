extends CharacterBody2D
class_name Boat 

@export var sprite: Sprite2D

@export var boatType: String = "0"
@export var boatTier: String = "0"
var allMastsAreDown: bool


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

func _process(delta: float):
	if allMastsAreDown:
		if Input.is_action_just_pressed("button_a"):
			queue_free()
