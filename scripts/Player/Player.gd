extends CharacterBody2D
class_name Player

@export var player_inventory: Inventory
@export var player_movement: PlayerMovement
@export var animation_tree: AnimationTree
@export var loot_pickup: Area2D
@export var stun_timer: Timer

@onready var state_machine = animation_tree["parameters/playback"]

signal shop_exit

enum PlayerState {
	SWIMMING,
	TRADING,
	INVENTORY,
	PAUSED,
	CC,
}

var current_state: PlayerState = PlayerState.SWIMMING

func _ready() -> void:
	loot_pickup.area_entered.connect(_handleLootPickUp)
	stun_timer.timeout.connect(_stun_ended)

func _handleLootPickUp(area: Area2D) -> void:
	var item := area as WorldItem
	if item:
		if item.current_state == item.LocomotionState.FLOATING:
			player_inventory.add_item(item.item_resource, item.amount)
			item.DespawnItem()
		else:
			await get_tree().create_timer(0.62).timeout
			if loot_pickup.overlaps_area(item):
				_handleLootPickUp(item)
	return

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

func OnShopExit(target: Vector2, use_own_x: bool, use_own_y: bool) -> void:
	if use_own_x:
		target.x = global_position.x
	if use_own_y:
		target.y = global_position.y
	velocity = Vector2.ZERO
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", target, 0.4)
	await tween.finished
	change_state(PlayerState.SWIMMING)
	player_movement.ToggleMovement(true)
	print(player_inventory.coins)

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

func stun_animation() -> void:
	state_machine.travel("player_hurt")

func GetHit():
	player_movement.ToggleMovement(false)
	stun_timer.start()
	var target = global_position + Vector2.DOWN * 144
	stun_animation()
	velocity = Vector2.ZERO
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", target, 1)
	await tween.finished
	#change_state(PlayerState.CC)

func _stun_ended() -> void:
	#change_state(PlayerState.SWIMMING)
	player_movement.ToggleMovement(true)
