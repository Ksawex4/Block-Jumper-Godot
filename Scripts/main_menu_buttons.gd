extends Control

func _on_quit_button_pressed() -> void:
	Global.saveAchievements()
	get_tree().quit()

func _on_new_button_pressed() -> void:
	#this is temporary
	if FileAccess.file_exists("user://trash"):
		get_tree().change_scene_to_file("res://Scenes/trash_room.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/test_room.tscn")

func _on_achievements_button_pressed() -> void:
	get_parent().get_node("Fency").position = Vector2(-64, 751)

func _on_load_button_pressed() -> void:
	BobSpawn.TotalBobs = 0
	var scene
	if FileAccess.file_exists("user://save.bj") && !Global.SpeedrunMode:
		var file = FileAccess.open("user://save.bj", FileAccess.READ)
		var jsonString = file.get_as_text()
		var data = JSON.parse_string(jsonString)
		if data is Dictionary:
			var HPs = data.get("HPs")
			Global.FencyHP = HPs[0]
			Global.ToastyHP = HPs[1]
			Global.PanLoduwkaHP = HPs[2]
			var MaxHPs = data.get("MaxHPs")
			Global.FencyMaxHP = MaxHPs[0]
			Global.ToastyMaxHP = MaxHPs[1]
			Global.PanLoduwkaMaxHP = MaxHPs[2]
			scene = data.get("Scene")
			Global.Beans = data.get("Beans")
			var Stickz = data.get("Sticks")
			Global.FStick = Stickz[0]
			Global.TStick = Stickz[1]
			Global.PLStick = Stickz[2]
			Global.loadPositionX = float(data.get("X"))
			Global.loadPositionY = float(data.get("Y"))
			Global.loadPos = true
			TOASTS.TOAST = data.get("TOAST")
		file.close()
		get_tree().change_scene_to_file(scene)


func _on_settings_button_pressed() -> void:
	get_parent().get_node("Fency").position = Vector2(829, 731)
