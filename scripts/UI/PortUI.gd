extends Control
class_name PortUI

@export var target_location: int

func MoveShopIntoView():
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:x", target_location, 0.4)

func MoveShopOutOfView():
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:x", GlobalVariables.CAMERA_WIDTH, 0.4)
