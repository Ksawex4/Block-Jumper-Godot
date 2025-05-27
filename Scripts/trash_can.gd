extends CharacterBody2D

var isColliding := false

func _on_area_2d_body_entered(body: Node2D) -> void:
	isColliding = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	isColliding = false

func _process(delta: float) -> void:
	if isColliding && Input.is_action_just_pressed("Interract"):
		print("this will do smth soon")
		queue_free()
