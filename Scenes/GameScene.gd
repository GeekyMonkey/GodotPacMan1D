extends Node2D
class_name GameScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect to the level complete event
	GameEvents.LevelComplete.connect(OnLevelComplete)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func OnLevelComplete() -> void:
	# Load the next level
	get_tree().change_scene_to_file("res://scenes/GameScene.tscn")
