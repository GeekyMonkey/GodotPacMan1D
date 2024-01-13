class_name GameStateClass

extends Node

@export var Score: int = 0
@export var Playing: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StartGame()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Turn"):
		if Playing == false:
			StartGame()

func StartGame() -> void:
	get_tree().reload_current_scene()

	await XDelay.NextFrame()

	Score = 0
	GameEvents.ScoreChanged.emit(Score)

	Playing = true
	GameEvents.GameStarted.emit()

func AddPoints(points: int) -> void :
	Score += points
	GameEvents.ScoreChanged.emit(Score)

func GhostHitPlayer() -> void:
	GameEvents.PlayerDied.emit()

	Playing = false
	GameEvents.GameEnded.emit()
