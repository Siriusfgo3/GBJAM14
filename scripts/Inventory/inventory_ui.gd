extends Control

var is_open = false

func _ready() -> void:
	close()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("button_b"):
		if is_open:
			close()	
		else: 
			open()

func close():
	visible = false
	is_open = false
	
func open():
	visible = true
	is_open = true
	

	
	
