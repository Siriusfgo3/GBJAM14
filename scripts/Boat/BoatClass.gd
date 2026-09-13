extends CharacterBody2D
class_name Boat 

@export var sprite: Sprite2D
@export var inventory: Node

@export var boatType: int
@export var boatTier: int 
var allMastsAreDown: bool

var BOAT_PLACEHOLDER = sprite

func SpawnLoot():
	pass

func OnSpawn() -> void:
	SpawnLoot()

func _process(delta: float):
	if allMastsAreDown:
		if Input.is_action_just_pressed("button_a"):
			queue_free()
