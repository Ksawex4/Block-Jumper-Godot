extends CharacterBody2D

func _process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += Global.Gravity
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	Global.gotChip = true
	queue_free()
