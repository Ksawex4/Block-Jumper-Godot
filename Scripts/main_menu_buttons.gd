extends Control

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_new_button_pressed() -> void:
	call_deferred("changeScene", "res://Scenes/test_room.tscn")

func changeScene(scene):
	get_tree().change_scene_to_file(scene)
