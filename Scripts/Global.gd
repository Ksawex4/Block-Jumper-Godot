extends Node

var Gravity = 10
var FencyHP = 10
var ToastyHP = 10
var PanLoduwkaHP = 20
var FencyMaxHP = 10
var ToastyMaxHP = 10
var PanLoduwkaMaxHP = 20
var Beans = 0
var FollowWho = "Fency"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Quit"):
		QuitToMenu()
	
	if FencyHP <= 0 && PanLoduwkaHP <= 0 && ToastyHP <= 0:
		QuitToMenu()

func QuitToMenu():
	FencyHP = 10
	ToastyHP = 10
	PanLoduwkaHP = 20
	FollowWho = "Fency"
	Beans = 0
	get_tree().change_scene_to_file("res://Scenes/main_screen.tscn")
