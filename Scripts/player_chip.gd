extends CharacterBody2D

var damage = 5
@export var player = "Fency"

func _ready() -> void:
	if player == "Fency":
		$Sprite2D.texture = load("res://Textures/PlayerChips/FencyChip.png")
	elif player == "PanLoduwka":
		$Sprite2D.texture = load("res://Textures/PlayerChips/PanLoduwkaChip.png")
	elif player == "Toasty":
		$Sprite2D.texture = load("res://Textures/PlayerChips/ToastyChip.png")

func _process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += Global.Gravity
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == player:
		body.hurt(damage)
		queue_free()
