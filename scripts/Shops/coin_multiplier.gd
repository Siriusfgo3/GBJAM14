extends Node2D

@export var number_of_coins: int = 2

@onready var coin_multiplier = $coin_multiplier
@onready var coin_top = $coin_top

func coins(number_of_coins):
	if number_of_coins < 1:
		visible = false
	elif number_of_coins == 1:
		coin_multiplier.visible = false
	else:
		coin_top.position.y = -number_of_coins
		coin_multiplier.position.y = -(number_of_coins-2)*2+2
		coin_multiplier.scale.y = number_of_coins-1
		coin_multiplier.texture_scale.y = number_of_coins-1
