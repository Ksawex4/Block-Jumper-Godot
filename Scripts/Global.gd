extends Node

var Gravity = 10
var FencyHP = 10
var ToastyHP = 10
var PanLoduwkaHP = 10
var Beans = 0
var FollowWho = "Fency"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	var scene = get_tree().get_current_scene()
	if !scene.has_node("Fency") && !scene.has_node("Toasty") && !scene.has_node("PanLoduwka"):
		get_tree().quit()
	if Input.is_action_just_pressed("CamFency") && scene.has_node("Fency"):
		FollowWho = "Fency"
	elif Input.is_action_just_pressed("CamPanLoduwka") && scene.has_node("PanLoduwka"):
		FollowWho = "PanLoduwka"
	elif Input.is_action_just_pressed("CamToasty") && scene.has_node("Toasty"):
		FollowWho = "Toasty"
