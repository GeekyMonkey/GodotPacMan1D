## If the owner of this prefab goes outside of the world bounds, they will be teleported to the opposite side

class_name WorldWrapper
extends Node2D

var WorldWidth: float
var ParentObject: Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	WorldWidth = get_viewport_rect().size.x
	ParentObject = get_parent()

# Test if the object should be teleported
func _physics_process(_delta: float) -> void:
	if ParentObject.global_position.x < 0:
		ParentObject.global_position.x = WorldWidth
	elif ParentObject.global_position.x > WorldWidth:
		ParentObject.global_position.x = 0

