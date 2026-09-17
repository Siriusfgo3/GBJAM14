extends Node

@export var attack_hit_box: Area2D
var can_attack: bool = true

func _ready() -> void:
	attack_hit_box.monitoring = false
	attack_hit_box.area_entered.connect(_on_attack_area_entered)
	attack_hit_box.body_entered.connect(_on_body_hit)

func _unhandled_input(event: InputEvent) -> void:
	if not can_attack:
		return
	if event.is_action_pressed("button_b"):
		attack()
		#play animation
		get_viewport().set_input_as_handled()

func attack() -> void:
	#Flash the hitbox to detect hits:
	print("Flashing hitbox")
	attack_hit_box.monitoring = true
	await get_tree().create_timer(0.2).timeout  # or your attack anim length
	attack_hit_box.monitoring = false

func _on_attack_area_entered(area: Area2D) -> void:
	var mast := area.owner as BoatMast
	if mast:
		print("Calling Destroy mast")
		mast.DestroyMast()
		
func _on_body_hit(body: Node2D) -> void:
	var boat := body as Boat
	if boat:
		boat.TakeHit()
