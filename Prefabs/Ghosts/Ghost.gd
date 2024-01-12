## All ghost characters

class_name Ghost
extends Area2D

enum GhostNames {
	Inky,
	Blinky,
	Pinky,
	Clyde
}
var GhostName: String
var Direction: int = 1
var Target: Node2D
@export var Speed: float = 40.0
@onready var ghost_sprite: AnimatedSprite2D = $GhostSprite


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ChooseGhostName()
	FindPlayer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameState.Playing:
		position.x += Direction * Speed * delta

# Called every physics frame
func _physics_process(_delta: float) -> void:
	if Target.global_position.x > global_position.x:
		Direction = 1
	else:
		Direction = -1
	SetAnimation()

# Choose a random ghost name
func ChooseGhostName() -> void:
	var ghost_names = GhostNames.keys()
	GhostName = ghost_names[randi_range(0, ghost_names.size() -1)]

# Find the player
func FindPlayer() -> void:
	Target = get_tree().get_first_node_in_group("Player")

	# Watch for collision with player
	area_entered.connect(func(other: Node2D) -> void:
		if other.is_in_group("Player"):
			GameState.GhostHitPlayer()
	)

# Decide which animation to play
func SetAnimation() -> void:
	var left_or_right: String = "R" if Direction == 1 else "L"
	var anim: String = GhostName + left_or_right
	ghost_sprite.animation = anim
