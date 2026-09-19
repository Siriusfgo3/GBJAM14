extends Node2D
class_name BoatMast

@export var flag_sprite: Sprite2D
@export var damaged_sprite: Sprite2D
@onready var mastContainer = get_parent()
@export var area: Area2D

var isDestroyed: bool
var player_is_touching: bool

func _ready() -> void:
	isDestroyed = false
	flag_sprite.visible = true
	damaged_sprite.visible = false
	
	
func SetDamageable(damageable: bool) -> void:
	if isDestroyed:
		return
	area.set_deferred("monitorable", damageable)
	area.set_deferred("monitoring", damageable)


func DestroyMast() -> void:
	if isDestroyed: return
	isDestroyed = true
	area.set_deferred("monitorable", false)
	area.set_deferred("monitoring", false)
	flag_sprite.visible = false
	damaged_sprite.visible = true
	mastContainer.checkMasts()
