## The Player (PacMan)

class_name Player
extends Area2D

@export var Speed: float = 5.0
var DirectionX: int = 1

@onready var player_sprite: AnimatedSprite2D = $PlayerSprite
@onready var player_sound: AudioStreamPlayer2D = $PlayerSound
const DeathSound = preload("res://Sounds/death 1.ogg")
const DotSoundA = preload("res://Sounds/munch A.ogg")
const DotSoundB = preload("res://Sounds/munch B.ogg")
var DotSound = DotSoundA

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.PlayerDied.connect(func():
		player_sprite.animation = "PlayerDeath"
		player_sound.stream = DeathSound
		player_sound.play()
	)

	area_entered.connect(OnCollision)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Left"):
		DirectionX = -1
	elif Input.is_action_just_pressed("Right"):
		DirectionX = 1
	elif Input.is_action_just_pressed("Turn"):
		DirectionX = -DirectionX

# Called every physics frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if GameState.Playing:
		position.x += Speed * DirectionX * delta
		if DirectionX == 1:
			player_sprite.animation = "PlayerR"
		else:
			player_sprite.animation = "PlayerL"

func OnCollision(other: Node2D):
	if other.is_in_group("Dots"):
		player_sound.stream = DotSound
		player_sound.play()
		DotSound = DotSoundA if DotSound == DotSoundB else DotSoundB

