extends Node2D

@export var item: InvItem
var player = null

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
		add_to_player_inventory()
		queue_free()

func add_to_player_inventory():
	player.collect(item)
