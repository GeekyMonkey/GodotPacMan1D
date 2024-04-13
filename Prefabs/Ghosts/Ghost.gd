## All ghost characters

class_name Ghost
extends Area2D
const EyesPrefab = preload("res://Prefabs/Ghosts/Eyes.tscn")
const GhostEatSound = preload("res://Sounds/ghost eat 7.ogg")


@onready var GhostSound: AudioStreamPlayer2D = $GhostSound

enum GhostNames {
	Inky,
	Blinky,
	Pinky,
	Clyde
}
var GhostName: String
var Direction: int = 1
var Dead: bool = false
var Target: Node2D
var Afraid: bool = false

@export var Speed: float = 40.0
@export var Points: int = 100
@onready var ghost_sprite: AnimatedSprite2D = $GhostSprite


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ChooseGhostName()
	FindPlayer()

	# Should the ghost be afraid
	GameEvents.PowerModeChanged.connect(func(power: bool) -> void:
		Afraid = power
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# Called every physics frame
func _physics_process(delta: float) -> void:
	if Dead:
		if GhostSound.playing == false:
			queue_free()
		return

	if not Target:
		Direction = 0
	elif Target.global_position.x > global_position.x:
		Direction = 1
	else:
		Direction = -1

	# Run away when afraid
	if Afraid:
		Direction = -Direction

	if GameState.Playing:
		position.x += Direction * Speed * delta

	SetAnimation()

# Choose a random ghost name
func ChooseGhostName() -> void:
	var ghost_names = GhostNames.keys()
	GhostName = ghost_names[randi_range(0, ghost_names.size() -1)]

# Find the player
func FindPlayer() -> void:
	Target = get_tree().get_first_node_in_group("Players")

	# Watch for collision with player
	area_entered.connect(func(other: Node2D) -> void:
		if other.is_in_group("Players"):
			if Afraid:
				GameState.PlayerHitGhost(self)
				Die()
			else:
				GameState.GhostHitPlayer()
	)

# Decide which animation to play
func SetAnimation() -> void:
	if Afraid:
		ghost_sprite.animation = "Afraid"
	else:
		var left_or_right: String = "R" if Direction == 1 else "L"
		ghost_sprite.animation = GhostName + left_or_right


# The ghost ... died?
func Die() -> void:
	SpawnEyes()
	GhostSound.stream = GhostEatSound
	GhostSound.play()
	Dead = true
	ghost_sprite.visible = false

# Create the eyes exting
func SpawnEyes() -> void:
	var eyes: Eyes = EyesPrefab.instantiate()
	get_parent().add_child(eyes)
	eyes.position = self.position

