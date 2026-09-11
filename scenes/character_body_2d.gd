extends CharacterBody2D

const MIN_X := 0.0
const MAX_X := 1000.0


const SPEED = 200.0
var in_frame = false

func _physics_process(_delta: float) -> void:
	print(position.x)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if position.x >= 0 and position.x <= 1000:
		in_frame = true
	else:
		in_frame = false
	
	if direction and in_frame:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0

	move_and_slide()
	position.x = clamp(position.x, MIN_X, MAX_X)
