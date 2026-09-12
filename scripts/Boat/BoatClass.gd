extends CharacterBody2D

@export var sprite: Sprite2D

var boatType: String = "null"
var boatTier: String = "null"

const BOAT_PLACEHOLDER = preload("res://sprites/BoatPlaceholder.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
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
