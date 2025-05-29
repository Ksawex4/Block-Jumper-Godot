extends CharacterBody2D

@export var Size = Vector2(1, 1)

func _ready() -> void:
	$NinePatchRect/AnimationPlayer.play("BeanBlock")
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$NinePatchRect.size = Size
	$CollisionShape2D.shape.size = Size
	$NinePatchRect.anchor_left = 0
	$NinePatchRect.anchor_right = 0
	$NinePatchRect.anchor_top = 0
	$NinePatchRect.anchor_bottom = 0
	$NinePatchRect.position = -Size / 2
	$CollisionShape2D.shape.size = Size
	$CollisionShape2D.position = Vector2.ZERO
	$NinePatchRect/AnimationPlayer.get_animation("BeanBlock").loop = true
