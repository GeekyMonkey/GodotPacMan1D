## Ghost Eyes

class_name Eyes
extends Area2D

var Direction: int = 1
var Target: Node2D
var WorldWidth: float

@export var Speed: float = 40.0
@onready var eyes_sprite: AnimatedSprite2D = $EyesSprite


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	WorldWidth = get_viewport_rect().size.x
	FindPlayer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# Called every physics frame
func _physics_process(delta: float) -> void:
	if Target.global_position.x > global_position.x:
		Direction = -1
	else:
		Direction = 1

	if GameState.Playing:
		position.x += Direction * Speed * delta

	SetAnimation()
	CheckOffScreen()

# Find the player
func FindPlayer() -> void:
	Target = get_tree().get_first_node_in_group("Player")

# Decide which animation to play
func SetAnimation() -> void:
	var left_or_right: String = "R" if Direction == 1 else "L"
	eyes_sprite.animation = "Eyes" + left_or_right

func CheckOffScreen() -> void :
	if (position.x >= WorldWidth) or (position.x <= 0):
		queue_free()
