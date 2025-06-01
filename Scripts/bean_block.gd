extends CharacterBody2D

@export var isVisible = true

func _ready() -> void:
	visible = isVisible
	var scaleMultiplier = scale
	scale = Vector2(1.0, 1.0)
	$NinePatchRect/AnimationPlayer.play("BeanBlock")
	$NinePatchRect/AnimationPlayer.get_animation("BeanBlock").loop = true
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$NinePatchRect.size *= scaleMultiplier
	$CollisionShape2D.shape.size *= scaleMultiplier
	$NinePatchRect.anchor_left = 0
	$NinePatchRect.anchor_right = 0
	$NinePatchRect.anchor_top = 0
	$NinePatchRect.anchor_bottom = 0
	$CollisionShape2D.position = Vector2.ZERO
	$NinePatchRect.position = -$CollisionShape2D.shape.size / 2
