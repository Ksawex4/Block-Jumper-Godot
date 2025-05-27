extends CharacterBody2D

var isColliding := false

func _on_area_2d_body_entered(body: Node2D) -> void:
	isColliding = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	isColliding = false

func _process(delta: float) -> void:
	if isColliding && Input.is_action_just_pressed("Interract"):
		isColliding = false
		spawnSpamGuy()
		queue_free()

func spawnSpamGuy():
	var shouldSpawn = randf_range(0.0, 10.0)
	if shouldSpawn < 2.0:
		var spam = preload("res://Scenes/Objects/spamguys.tscn").instantiate()
		spam.position = Vector2(position.x + 70, position.y)
		get_tree().current_scene.add_child(spam)
