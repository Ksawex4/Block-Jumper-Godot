extends CharacterBody2D

var scene

func _ready() -> void:
	scene = get_tree().current_scene
	$AudioStreamPlayer2D.play()

func _process(delta: float) -> void:
	var rand = randi_range(1, 3)
	if scene.has_node("Fency") && rand == 1:
		position = Vector2(scene.get_node("Fency").position.x + randf_range(-100, 100), scene.get_node("Fency").position.y + randf_range(-100,100))
	if scene.has_node("Toasty") && rand == 2:
		position = Vector2(scene.get_node("Toasty").position.x + randf_range(-100, 100), scene.get_node("Toasty").position.y + randf_range(-100,100))
	if scene.has_node("PanLoduwka") && rand == 3:
		position = Vector2(scene.get_node("PanLoduwka").position.x + randf_range(-100, 100), scene.get_node("PanLoduwka").position.y + randf_range(-100,100))
	
