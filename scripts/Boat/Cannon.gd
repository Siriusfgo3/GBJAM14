class_name Cannon
extends Node2D

@export var muzzle: Marker2D
@export var cannonTimer: Timer
@export var fire_rate: float = 1 #Hz
@export var cannonball_scene: PackedScene
@export var immediately_activate: bool = false

func _ready() -> void:
	cannonTimer.one_shot = true
	cannonTimer.timeout.connect(_shoot_cannon)
	if immediately_activate:
		_activate_cannon()

func _activate_cannon():
	cannonTimer.start(GetSecondsUntilNextShot())
	
func _deactivate_cannon():
	cannonTimer.stop()

func _shoot_cannon():
	var player := get_tree().get_first_node_in_group("Player") as Node2D
	
	var start := muzzle.global_position.round()
	var target := player.global_position.round()
	
	var ball := cannonball_scene.instantiate() as EnemyProjectile
	_world().add_child(ball)
	ball.initiate_path(start, target)
	SoundManager.play_sound("CannonShot")
	
	cannonTimer.start(GetSecondsUntilNextShot())
	
func _world() -> Node:
	return get_parent().get_parent()
	
func GetSecondsUntilNextShot():
	return 1 / fire_rate
