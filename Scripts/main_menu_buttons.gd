extends Control

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_new_button_pressed() -> void:
	#this is temporary
	if FileAccess.file_exists("user://trash"):
		get_tree().change_scene_to_file("res://Scenes/trash_room.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/test_room.tscn")

func _on_achievements_button_pressed() -> void:
	get_parent().get_node("Fency").position = Vector2(-64, 751)
