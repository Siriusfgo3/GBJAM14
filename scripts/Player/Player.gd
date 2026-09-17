extends CharacterBody2D
class_name Player

@export var player_inventory: Inventory
@export var player_movement: PlayerMovement
@export var animation_tree: AnimationTree

@onready var state_machine = animation_tree["parameters/playback"]

signal shop_exit

enum PlayerState {
	SWIMMING,
	TRADING,
	INVENTORY,
	PAUSED,
}

var current_state: PlayerState = PlayerState.SWIMMING



func _input(event) -> void:
	match current_state:
		PlayerState.TRADING:
			if event.is_action_pressed("button_b"):
				shop_exit.emit()

func get_inventory() -> Inventory:
	return player_inventory
	
func OnShopEntered() -> void:
	change_state(PlayerState.TRADING)
	player_movement.ToggleMovement(false)

func OnShopExit(target: Vector2) -> void:
	velocity = Vector2.ZERO
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", target, 0.4)
	await tween.finished
	change_state(PlayerState.SWIMMING)
	player_movement.ToggleMovement(true)

func change_state(new_state: PlayerState):
	if current_state == new_state:
		return
	current_state = new_state

func move_animation(direction: Vector2) -> void:
	
	if direction.x:
		$PlayerVisual.scale.x = direction.x
		$attack_hitbox.scale.x = direction.x
		
func attack_animation() -> void:
	state_machine.travel("player_attack_small")
	
