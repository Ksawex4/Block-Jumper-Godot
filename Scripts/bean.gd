extends CharacterBody2D

@export var value = 1

func _physics_process(_delta: float) -> void:
	velocity.y += Global.Gravity
	move_and_slide()

func _on_area_2d_body_entered(_body: Node2D) -> void:
	queue_free()
	Global.Beans += value
	print(Global.Beans)
