extends Node2D
class_name boatMast

@export var flag_sprite: Sprite2D
@export var damaged_sprite: Sprite2D
@export var area: Area2D

var isDestroyed: bool
var player_is_touching: bool

func _ready() -> void:
	isDestroyed = false
	flag_sprite.visible = true
	damaged_sprite.visible = false
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exit)
		
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_is_touching = true
		var player = body
			
func _on_body_exit(body: Node2D):
	if body.is_in_group("Player"):
		player_is_touching = false

func _process(delta: float) -> void:
	if player_is_touching:
		if Input.is_action_just_pressed("button_a") && !isDestroyed:
			isDestroyed = true
			area.disable_mode
			flag_sprite.visible = false
			damaged_sprite.visible = true
