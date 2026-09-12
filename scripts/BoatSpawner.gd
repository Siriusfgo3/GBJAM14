extends Node
class_name BoatSpawner

@export var boat_scene: PackedScene
var SPAWN_POSITION: int = -50

func SpawnBoat(boatType: String, boatTier: String) -> void:
	print("Called spawn boat")
	var boat = boat_scene.instantiate()
	boat.OnSpawn(boatType, boatTier)
	boat.global_position.x = SPAWN_POSITION
	get_parent().add_child.call_deferred(boat)

func _ready() -> void:
	SpawnBoat("null", "null")
