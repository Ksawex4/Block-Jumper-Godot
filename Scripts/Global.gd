extends Node

var Gravity = 10
var FencyHP = 10
var ToastyHP = 10
var PanLoduwkaHP = 10
var Beans = 0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	var scene = get_tree().get_current_scene()
	if !scene.has_node("Fency") && !scene.has_node("Toasty") && !scene.has_node("PanLoduwka"):
		get_tree().quit()
