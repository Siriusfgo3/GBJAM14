extends Node

@export var speed: float = 25.0
var direction: int = 1

@export var min_dt: float = 1
@export var max_dt: float = 3

@export var _body: CharacterBody2D

@export var sailDirectionTimer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sailDirectionTimer.one_shot = true
	sailDirectionTimer.timeout.connect(_on_timeout)
	_on_timeout()

func _on_timeout() -> void:
	direction *= -1
	_body.velocity.x = direction * speed
	sailDirectionTimer.start(randf_range(min_dt, max_dt))
	
func _physics_process(_delta: float) -> void:
	_body.move_and_slide()
