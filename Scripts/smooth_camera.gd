extends Camera2D

func _process(delta: float) -> void:
	var scene = get_tree().get_current_scene()
	var node = scene.get_node_or_null(Global.FollowWho)
	
	if node != null:
		position.x = lerp(position.x, node.position.x, 0.1)
		position.y = lerp(position.y, node.position.y, 0.1)
	
	if Input.is_action_just_pressed("CamFency") && scene.has_node("Fency"):
		Global.FollowWho = "Fency"
	elif Input.is_action_just_pressed("CamPanLoduwka") && scene.has_node("PanLoduwka"):
		Global.FollowWho = "PanLoduwka"
	elif Input.is_action_just_pressed("CamToasty") && scene.has_node("Toasty"):
		Global.FollowWho = "Toasty"
