extends Node

var loadPositionX = 0.0
var loadPositionY = 0.0
var loadPos = false 
var Gravity := 10
var FencyHP := 10
var ToastyHP := 10
var PanLoduwkaHP := 20
var FencyMaxHP := 10
var ToastyMaxHP := 10
var PanLoduwkaMaxHP := 20
var FStick := true
var PLStick := true
var TStick := true
var Beans := 0
var FollowWho := "Fency"
var spawn := 0
var playerAchievements := []
var shownAchievements := []

func _ready():
	if FileAccess.file_exists("user://achievements.bj"):
		loadAchievements()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Quit"):
		QuitToMenu()
	
	if FencyHP <= 0 && PanLoduwkaHP <= 0 && ToastyHP <= 0:
		QuitToMenu()

func QuitToMenu():
	if get_tree().current_scene.scene_file_path != "res://Scenes/main_menu.tscn":
		FencyHP = 10
		ToastyHP = 10
		PanLoduwkaHP = 20
		FollowWho = "Fency"
		Beans = 0
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	else:
		get_tree().current_scene.get_node("Fency").position = Vector2(277, 163)
		

func loadAchievements():
	var file = FileAccess.open("user://achievements.bj", FileAccess.READ)
	var jsonString = file.get_as_text()
	var data = JSON.parse_string(jsonString)
	if data is Dictionary:
		playerAchievements = data.get("achievements")
		shownAchievements = data.get("shownAchievements")
	file.close()

func saveAchievements():
	var struct = {
		"achievements": Global.playerAchievements,
		"shownAchievements": Global.shownAchievements
	}
	var file = FileAccess.open("user://achievements.bj", FileAccess.WRITE)
	var jsonString = JSON.stringify(struct)
	file.store_string(jsonString)
	file.close()

func saveGame(pos):
	saveAchievements()
	var struct = {
		"X": pos.x,
		"Y": pos.y,
		"HPs": [FencyHP, ToastyHP, PanLoduwkaHP],
		"MaxHPs": [FencyMaxHP, ToastyMaxHP, PanLoduwkaMaxHP],
		"Scene": get_tree().current_scene.scene_file_path,
		"Sticks": [FStick, TStick, PLStick],
		"Beans": Beans
	}
	var file = FileAccess.open("user://save.bj", FileAccess.WRITE)
	var jsonString = JSON.stringify(struct)
	file.store_string(jsonString)
	file.close()
