class_name GameText

extends CanvasLayer

@onready var score_value: RichTextLabel = $ScoreValue


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.ScoreChanged.connect(OnScoreChanged)


func OnScoreChanged(score: int) -> void:
	score_value.text = str(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
