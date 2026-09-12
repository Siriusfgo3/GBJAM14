extends Node
class_name BoatSpawner

@export var boat_scene: PackedScene
var SPAWN_POSITION: int = -50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func SpawnBoat(boatType: String, boatTier: String) -> void:
	print("Called spawn boat")
	var boat = boat_scene.instantiate()
	boat.OnSpawn(boatType, boatTier)
	boat.global_position.x = SPAWN_POSITION
	get_parent().add_child(boat)
