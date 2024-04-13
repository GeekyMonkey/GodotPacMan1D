class_name PowerDot

extends Area2D

@onready var dot_sprite: Sprite2D = $DotSprite

@export var IsPowerDot: bool = false
@export var Points: int = 10

var DotActive: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(OnCollision)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func OnCollision(other: Node2D) -> void:
	if other.is_in_group("Players"):
		GameState.AddPoints(Points)

		if IsPowerDot:
			GameState.PowerDotEaten()
		else:
			GameState.DotEaten()

		queue_free()
