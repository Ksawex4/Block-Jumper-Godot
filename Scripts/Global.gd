extends Node

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
		
