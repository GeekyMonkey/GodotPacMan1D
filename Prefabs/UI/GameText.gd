class_name GameText

extends CanvasLayer

@onready var score_value: RichTextLabel = $ScoreValue
@onready var hi_value: RichTextLabel = $HiValue
@onready var start_label: RichTextLabel = $StartLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.ScoreChanged.connect(OnScoreChanged)
	start_label.visible = false
	GameEvents.GameEnded.connect(OnGameEnded)

	# Update the text on level scene change
	score_value.text = str(GameState.Score)
	hi_value.text = str(GameState.HighScore)

func OnScoreChanged(score: int) -> void:
	score_value.text = str(score)
	hi_value.text = str(GameState.HighScore)

func OnGameEnded() -> void:
	start_label.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
