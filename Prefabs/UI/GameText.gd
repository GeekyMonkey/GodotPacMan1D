class_name GameText

extends CanvasLayer

@onready var score_value: RichTextLabel = $ScoreValue
@onready var start_label: RichTextLabel = $StartLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.ScoreChanged.connect(OnScoreChanged)
	start_label.visible = false
	GameEvents.GameEnded.connect(OnGameEnded)

func OnScoreChanged(score: int) -> void:
	score_value.text = str(score)

func OnGameEnded() -> void:
	start_label.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
