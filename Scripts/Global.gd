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
var gotChip = false
var chat = ""
var QueuedMessages = []
var IsTypingInChat = false
var ChatInstantSend = 512
var SolidBoxes = false
var AchSound = "res://SoundEffects/souAch.wav"
var timerF = 0
var timerS = 0
var timerM = 0
var SpeedrunMode = false

func _ready():
	if FileAccess.file_exists("user://achievements.bj"):
		loadAchievements()
	if FileAccess.file_exists("user://settings.bj") && TOASTS.TOAST != 16:
		Keys.LoadKeys()
	if FileAccess.file_exists("user://TimeSave"):
		SpeedrunMode = true
		var file = FileAccess.open("user://TimeSave",FileAccess.READ)
		var bobie = file.get_as_text()
		var data = JSON.parse_string(bobie)
		timerF = data.get("TimeF")
		

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("SpeedrunTimerOn"):
		timerF = 0
		timerS = 0
		timerM = 0
		BobSpawn.SavedBobs = 0
		BobSpawn.TotalBobs = 0
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
		playerAchievements = []
		shownAchievements = []
		SpeedrunMode = true
		
	
	if Input.is_action_just_pressed("Quit"):
		QuitToMenu()
	
	if FencyHP <= 0 && PanLoduwkaHP <= 0 && ToastyHP <= 0:
		QuitToMenu()
	
	if Input.is_key_pressed(KEY_B):
		var bouncy = load("res://Scenes/Objects/bouncy_onurb.tscn").instantiate()
		if get_tree().current_scene.has_node("Fency"):
			bouncy.position = get_tree().current_scene.get_node("Fency").position
			get_tree().current_scene.add_child(bouncy)
		elif get_tree().current_scene.has_node("PanLoduwka"):
			bouncy.position = get_tree().current_scene.get_node("PanLoduwka").position
			get_tree().current_scene.add_child(bouncy)
		elif get_tree().current_scene.get_node("Toasty"):
			bouncy.position = get_tree().current_scene.get_node("Toasty").position
			get_tree().current_scene.add_child(bouncy)

func QuitToMenu():
	if get_tree().current_scene.scene_file_path != "res://Scenes/main_menu.tscn" or SpeedrunMode:
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
		"Beans": Beans,
		"TOAST": TOASTS.TOAST
	}
	var file = FileAccess.open("user://save.bj", FileAccess.WRITE)
	var jsonString = JSON.stringify(struct)
	file.store_string(jsonString)
	file.close()
