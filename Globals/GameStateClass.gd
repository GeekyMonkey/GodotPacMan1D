class_name GameStateClass

extends Node

## How many seconds does a power dot give you a boost
@export var PowerDotSeconds: float = 4.0

## Current Game Score
var Score: int:
	get():
		return Score
	set(value):
		Score = value

## High Score
#ToDo: Save/Load
var HighScore: int = 0:
	get():
		return HighScore
	set(value):
		HighScore = value
		SaveHighScore()

## Is the game playing
var Playing: bool = false

## Seconds remaining in power mode
var PowerSeconds: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LoadHighScore()
	StartGame()

## Load the previous high score from a save file
func LoadHighScore() -> void:
	var config: ConfigFile = ConfigFile.new()
	if config.load("user://gamestate.cfg") == OK:
		HighScore = config.get_value("stats", "high_score", HighScore)

## Save the high score to a file
func SaveHighScore() -> void:
	var config: ConfigFile = ConfigFile.new()
	config.set_value("stats", "high_score", HighScore)
	config.save("user://gamestate.cfg")

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
	CheckLevelCompmlete()

func DotEaten() -> void:
	CheckLevelCompmlete()

func GhostHitPlayer() -> void:
	GameEvents.PlayerDied.emit()

	Playing = false
	GameEvents.GameEnded.emit()

func PlayerHitGhost(ghost: Ghost) -> void:
	AddPoints(ghost.Points)

## After a dot was eaten, check if the level is complete
func CheckLevelCompmlete() -> void:
	# Wait for dots to be removed
	await XDelay.NextFrame()

	var dots = get_tree().get_nodes_in_group("Dots")
	var dotCount: int = dots.size()
	print("Dot count = " + str(dotCount))
	if dotCount == 0:
		print("Level Complete")
		GameEvents.LevelComplete.emit()
