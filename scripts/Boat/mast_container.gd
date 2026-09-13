extends Node2D

var masts: Array[boatMast]

func _ready() -> void:
	masts = get_children() as Array[boatMast] 
