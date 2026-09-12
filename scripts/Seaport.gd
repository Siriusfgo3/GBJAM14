extends Node2D
class_name Seaport

signal seaport_entered
signal seaport_exited

@export var collider: CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exit)

func _on_body_exit(body: Node2D) -> void:
	if body.is_in_group("Player"):
		seaport_exited.emit()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		seaport_entered.emit()
	pass
	
func get_collider() -> CollisionShape2D:
	return collider
