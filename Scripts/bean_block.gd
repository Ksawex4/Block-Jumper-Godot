extends CharacterBody2D

@export var isVisible = true
@export var Block = "BeanBlock"

func _ready() -> void:
	if Block == "GrassBlock":
		$NinePatchRect.texture = load("res://Textures/Blocks/GrassBlock.png")
		zeroPatchMargin()
	if Block == "StoneBlock":
		$NinePatchRect.texture = load("res://Textures/Blocks/StoneBlock.png")
		zeroPatchMargin()
	visible = isVisible
	var scaleMultiplier = scale
	scale = Vector2(1.0, 1.0)
	if $NinePatchRect/AnimationPlayer.has_animation(Block):
		$NinePatchRect/AnimationPlayer.play(Block)
		$NinePatchRect/AnimationPlayer.get_animation(Block).loop = true
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$NinePatchRect.size *= scaleMultiplier
	$CollisionShape2D.shape.size *= scaleMultiplier
	$NinePatchRect.anchor_left = 0
	$NinePatchRect.anchor_right = 0
	$NinePatchRect.anchor_top = 0
	$NinePatchRect.anchor_bottom = 0
	$CollisionShape2D.position = Vector2.ZERO
	$NinePatchRect.position = -$CollisionShape2D.shape.size / 2

func zeroPatchMargin():
	$NinePatchRect.patch_margin_bottom = 0
	$NinePatchRect.patch_margin_left = 0
	$NinePatchRect.patch_margin_top = 0
	$NinePatchRect.patch_margin_right = 0
