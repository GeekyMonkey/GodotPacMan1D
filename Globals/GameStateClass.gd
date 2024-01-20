class_name GameStateClass

extends Node

## How many seconds does a power dot give you a boost
@export var PowerDotSeconds: float = 4.0

## Current Game Score
var Score: int = 0

## High Score
#ToDo: Save/Load
var HighScore: int = 0

## Is the game playing
var Playing: bool = false

## Seconds remaining in power mode
var PowerSeconds: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StartGame()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Turn"):
		if Playing == false:
			StartGame()

	if PowerSeconds > 0:
		PowerSeconds -= delta
		if PowerSeconds <= 0:
			PowerSeconds = 0
			GameEvents.PowerModeChanged.emit(false)

func StartGame() -> void:
	get_tree().reload_current_scene()

	await XDelay.NextFrame()

	Score = 0
	GameEvents.ScoreChanged.emit(Score)

	Playing = true
	GameEvents.GameStarted.emit()

func AddPoints(points: int) -> void :
	Score += points
	if Score > HighScore:
		HighScore = Score
	GameEvents.ScoreChanged.emit(Score)

func PowerDotEaten() -> void:
	PowerSeconds = PowerDotSeconds
	GameEvents.PowerModeChanged.emit(true)

func GhostHitPlayer() -> void:
	GameEvents.PlayerDied.emit()

	Playing = false
	GameEvents.GameEnded.emit()

func PlayerHitGhost(ghost: Ghost) -> void:
	AddPoints(ghost.Points)

