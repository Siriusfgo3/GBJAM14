extends Node2D

var masts: Array[BoatMast] = []
var mastsLeft: int
@onready var boat = get_parent() as Boat

func _ready() -> void:
	for mast in get_children():
		if mast is BoatMast:
			masts.append(mast)
	checkMasts()

func checkMasts():
	mastsLeft = 0
	for mast in masts:
		if !mast.isDestroyed:
			mastsLeft += 1 
	if mastsLeft == 0:
		boat.allMastsAreDown = true
