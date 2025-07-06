extends CharacterBody2D

@export var damage = 10

func _ready() -> void:
	if BobSpawn.SavedBobs == 6:
		queue_free()
