extends Camera2D

func _process(delta: float) -> void:
	var scene = get_tree().get_current_scene()
	var node = scene.get_node_or_null(Global.FollowWho)
	
	if node != null:
		position.x = lerp(position.x, node.position.x, 0.1)
		position.y = lerp(position.y, node.position.y, 0.1)
