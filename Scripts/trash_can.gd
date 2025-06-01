extends CharacterBody2D

var isColliding := false
@export var isInfinite := false

func _ready() -> void:
	if isInfinite:
		$Sprite2D.texture = load("res://Textures/TrashCan/InfiniteTrashCan.png")

func _on_area_2d_body_entered(body: Node2D) -> void:
	isColliding = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	isColliding = false

func _process(delta: float) -> void:
	if isColliding && Input.is_action_just_pressed("Interract"):
		spawnSpamGuy()
		if !isInfinite:
			isColliding = false
			queue_free()

func spawnSpamGuy():
	var shouldSpawn = randf_range(0.0, 10.0)
	if shouldSpawn < 2.0:
		var spam = preload("res://Scenes/Objects/spamguys.tscn").instantiate()
		var enemies = get_tree().current_scene.get_node("Enemies")
		spam.position = Vector2(position.x + 100, position.y)
		if enemies:
			enemies.add_child(spam)
		else:
			get_tree().current_scene.add_child(spam)
