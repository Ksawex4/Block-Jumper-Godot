extends CharacterBody2D

func _process(_delta: float) -> void:
	if !is_on_floor():
		velocity.y += Global.Gravity
	move_and_slide()

func _on_area_2d_body_entered(_body: Node2D) -> void:
	Global.gotChip = true
	queue_free()
	print("chip: player got me")
