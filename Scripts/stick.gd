extends CharacterBody2D

var who = "Fency"
var stick = "FStick"

func _process(delta: float) -> void:
	var scene = get_tree().current_scene
	if scene.has_node(who):
		position = scene.get_node(who).position
		if !Global.get(stick):
			queue_free()
	else:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("body entered: " + str(body))
	print("removing enemy")
	body.queue_free()
	Global.set(stick, false)
	queue_free()
