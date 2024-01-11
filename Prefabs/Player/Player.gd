## The Player (PacMan)

class_name Player
extends Area2D

@export var Speed: float = 5.0
var DirectionX: int = 1

@onready var player_sprite: AnimatedSprite2D = $PlayerSprite


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Left"):
		DirectionX = -1
	elif Input.is_action_just_pressed("Right"):
		DirectionX = 1
	elif Input.is_action_just_pressed("Turn"):
		DirectionX = -DirectionX

# Called every physics frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.x += Speed * DirectionX * delta
	if DirectionX == 1:
		player_sprite.animation = "PlayerR"
	else:
		player_sprite.animation = "PlayerL"

