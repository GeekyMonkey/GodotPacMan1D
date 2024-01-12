class_name Dot

extends Area2D
@onready var dot_sound: AudioStreamPlayer2D = $DotSound
@onready var dot_sprite: Sprite2D = $DotSprite

var DotActive: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(OnCollision)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func OnCollision(other: Node2D) -> void:
	if DotActive == false:
		return

	GameState.AddPoints(1)

	DotActive = false
	dot_sprite.queue_free()

	dot_sound.play()
	dot_sound.connect("finished", func() -> void:
		queue_free()
	)
