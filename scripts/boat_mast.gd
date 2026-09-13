extends Node2D

@export var flag_sprite: Sprite2D
@export var damaged_sprite: Sprite2D
@export var area: Area2D

var isDestroyed: bool

func _ready() -> void:
	isDestroyed = false
	flag_sprite.visible = true
	damaged_sprite.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var player = body
		if Input.is_action_just_pressed("button_a") && !isDestroyed:
			isDestroyed = true
			area.disable_mode
			flag_sprite.visible = false
			damaged_sprite.visible = true
