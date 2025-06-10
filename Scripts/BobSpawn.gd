extends Node

var SpawnPos = 3855977
var TotalBobs = 0
var SavedBobs = 0

func _ready() -> void:
	if FileAccess.file_exists("user://The Bobs have awoken.BOB"):
		var file = FileAccess.open("user://The Bobs have awoken.BOB", FileAccess.READ)
		var jsonString = file.get_as_text()
		var data = JSON.parse_string(jsonString)
		SavedBobs = data.get("BOB")

func _process(delta: float) -> void:
	if SavedBobs >= 1: # BOB BOB BOB BOB BOB BOB BOB BOB BOB BOB BOB BOB BOB BOB, This Bob is not finished yet beacuse IM TAKING TOO LONG
		385597
	if TotalBobs < SavedBobs:
		spawnBob()
		print("Spawned Bob")
	var FY
	var PLY
	var TY
	if get_tree().current_scene != null:
		if get_tree().current_scene.has_node("Fency"):
			FY = get_tree().current_scene.get_node("Fency").position.y
		if get_tree().current_scene.has_node("PanLoduwka"):
			PLY = get_tree().current_scene.get_node("PanLoduwka").position.y
		if get_tree().current_scene.has_node("Toasty"):
			TY = get_tree().current_scene.get_node("Toasty").position.y
		if get_tree().current_scene.scene_file_path != "res://Scenes/main_menu.tscn":
			if FY != null:
				if FY >= SpawnPos:
					SpawnPos = 9999999999999999
					spawnBob()
					SaveBOB()
					get_tree().quit()
			if PLY != null:
				if PLY >= SpawnPos:
					SpawnPos = 9999999999999999
					spawnBob()
					SaveBOB()
					get_tree().quit()
			if TY != null:
				if TY >= SpawnPos:
					SpawnPos = 9999999999999999
					spawnBob()
					SaveBOB()
					get_tree().quit()

func SaveBOB():
	Global.playerAchievements.append("[img]res://Textures/Achievements/BOB.png[/img]")
	Global.saveAchievements()
	if Global.SpeedrunMode:
		var speeeed = {
			"TimeF": Global.timerF + Global.timerS * 60 + Global.timerM * 60 * 60
		}
		var feli = FileAccess.open("user://TimeSave", FileAccess.WRITE)
		var jsan = JSON.stringify(speeeed)
		feli.store_string(jsan)
		feli.close()
	var struct = {
		"BOB": TotalBobs
	}
	var file = FileAccess.open("user://The Bobs have awoken.BOB", FileAccess.WRITE)
	var jsonString = JSON.stringify(struct)
	file.store_string(jsonString)
	file.close()

func spawnBob():
	var buble = load("res://Scenes/Objects/bob.tscn").instantiate()
	get_tree().current_scene.add_child(buble)
	TotalBobs += 1
