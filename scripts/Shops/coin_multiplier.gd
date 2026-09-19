extends Node2D
class_name CoinStack

@export var number_of_coins: int = 0

@onready var coin_multiplier = $coin_multiplier
@onready var coin_top = $coin_top

func _ready() -> void:
	coins(number_of_coins)

func coins(_number_of_coins: float):
	number_of_coins = ceil(_number_of_coins)
	if number_of_coins < 1:
		visible = false
	#elif number_of_coins == 1:
	#	coin_multiplier.visible = false
	else:
		coin_top.position.y = -number_of_coins
		coin_multiplier.position.y = -(number_of_coins-2)*2+2
		coin_multiplier.scale.y = number_of_coins-1
		coin_multiplier.texture_scale.y = number_of_coins-1
		visible = true
		print("[CoinStack] Current money: " + str(number_of_coins))

func add_coins(amount: int) -> void:
	coins(number_of_coins + amount)
