extends Node

var Gravity = 10

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
