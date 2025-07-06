extends CharacterBody2D

var scene

func _ready() -> void:
	scene = get_tree().current_scene
	$AudioStreamPlayer2D.play()
	$Area2D/CollisionShape2D.disabled = false

func _process(delta: float) -> void:
	var rand = randi_range(1, 3)
	if scene.has_node("Fency") && rand == 1:
		position = Vector2(scene.get_node("Fency").position.x + randf_range(-100, 100), scene.get_node("Fency").position.y + randf_range(-100,100))
	if scene.has_node("Toasty") && rand == 2:
		position = Vector2(scene.get_node("Toasty").position.x + randf_range(-100, 100), scene.get_node("Toasty").position.y + randf_range(-100,100))
	if scene.has_node("PanLoduwka") && rand == 3:
		position = Vector2(scene.get_node("PanLoduwka").position.x + randf_range(-100, 100), scene.get_node("PanLoduwka").position.y + randf_range(-100,100))
	
	var BouncyRand = randi_range(1,100)
	if BouncyRand < 4 && BobSpawn.SavedBobs >= 7:
		var Bounce = load("res://Scenes/Objects/bouncy_onurb.tscn").instantiate()
		scene.add_child(Bounce)
		Bounce.position = position

func _on_area_2d_body_entered(body: Node2D) -> void:
	if randi_range(1,100) == 37 && BobSpawn.SavedBobs >= 2:
		if body.has_node("Sprite2D") or body.has_node("AnimatedSprite2D") or body.has_node("NinePatchRect"):
			var sprit
			if body.has_node("Sprite2D"):
				sprit = body.get_node("Sprite2D")
			elif body.has_node("AnimatedSprite2D"):
				sprit = body.get_node("AnimatedSprite2D")
			else:
				sprit = body.get_node("NinePatchRect")
			var mat = ShaderMaterial.new()
			mat.shader = load("res://Shaders/Glitched.gdshader")
			sprit.material = mat
