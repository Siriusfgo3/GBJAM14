extends Node

@export var aggroArea: Area2D
@export var cannonContainer: Node2D

var cannons: Array[Cannon] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	aggroArea.body_entered.connect(_on_body_entered)
	aggroArea.body_exited.connect(_on_body_exited)
	
	for child in cannonContainer.get_children():
		if child is Cannon:
			cannons.append(child)

func _on_body_entered(body: Node2D) -> void:
	#print("[Ship]: Engaging Player!")
	if body.is_in_group("Player"):
		ToggleCannons(true)
		IsAttackable(true)
		
		
func _on_body_exited(body: Node2D) -> void:
	#print("[Ship]: Lost Player...")
	if body.is_in_group("Player"):
		ToggleCannons(false)
		IsAttackable(false)
		
func ToggleCannons(_active: bool) -> void:
	for cannon in cannons:
		if _active:
			cannon._activate_cannon()
		else:
			cannon._deactivate_cannon()

func IsAttackable(_active: bool) -> void:
	pass
	#if _active:
		#print("Can be attacked")
