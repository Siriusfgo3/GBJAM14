extends Node
class_name seaweed_spawner

@export var seaweed_scene: PackedScene
var SPAWN_POSITION: int = 50

func SpawnSeaweed() -> void:
	var seaweed = seaweed_scene.instantiate()
	seaweed.global_position.x = SPAWN_POSITION
	get_parent().add_child.call_deferred(seaweed)

func _ready() -> void:
	SpawnSeaweed()
