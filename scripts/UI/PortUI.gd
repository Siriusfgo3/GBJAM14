extends Control
class_name PortUI

@export var inview_location: Vector2
@export var outofview_location: Vector2
@export var transition_speed: float = 0.4

func MoveShopIntoView():
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", inview_location, transition_speed)

func MoveShopOutOfView():
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "position", outofview_location, transition_speed)
