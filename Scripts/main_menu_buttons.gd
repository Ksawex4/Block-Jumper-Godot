extends Control

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_new_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/test_room.tscn")
