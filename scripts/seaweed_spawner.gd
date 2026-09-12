extends Node
class_name seaweed_spawner

var rng = RandomNumberGenerator.new()
@export var seaweed_scene: PackedScene
var spawn_position_x: int = rng.randf_range(20,400)
var spawn_position_y: int = rng.randf_range(150,200)

func SpawnSeaweed() -> void:
	var seaweed = seaweed_scene.instantiate()
	seaweed.global_position.x = spawn_position_x
	seaweed.global_position.y = spawn_position_y
	get_parent().add_child.call_deferred(seaweed)

func _ready():
	SpawnSeaweed()
	
