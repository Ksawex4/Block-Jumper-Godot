extends Node

var FLeft = KEY_A
var FRight = KEY_D
var FJump = KEY_W
var TLeft = KEY_J
var TRight = KEY_L
var TJump = KEY_I
var PLLeft = KEY_F
var PLRight = KEY_H
var PLJump = KEY_T
var Interract = KEY_Z
var CamF = KEY_1
var CamPL = KEY_2
var CamT = KEY_3

func SaveKeys():
	var struct = {
		"FencyLeft": FLeft,
		"FencyRight": FRight,
		"FencyJump": FJump,
		"ToastyLeft": TLeft,
		"ToastyRight": TRight,
		"ToastyJump": TJump,
		"PanLoduwkaLeft": PLLeft,
		"PanLoduwkaRight": PLRight,
		"PanLoduwkaJump": PLJump,
		"Interract": Interract,
		"CamFency": CamF,
		"CamPanLoduwka": CamPL,
		"CamToasty": CamT
	}
	var file = FileAccess.open("user://settings.bj", FileAccess.WRITE)
	var jsonString = JSON.stringify(struct)
	file.store_string(jsonString)
	file.close()

func LoadKeys():
	var file = FileAccess.open("user://settings.bj", FileAccess.READ)
	var jsonString = file.get_as_text()
	var data = JSON.parse_string(jsonString)
	if data is Dictionary:
		FLeft = data.get("FencyLeft")
		FRight = data.get("FencyRight")
		FJump = data.get("FencyJump")
		TLeft = data.get("ToastyLeft")
		TRight = data.get("ToastyRight")
		TJump = data.get("ToastyJump")
		PLLeft = data.get("PanLoduwkaLeft")
		PLRight = data.get("PanLoduwkaRight")
		PLJump = data.get("PanLoduwkaJump")
		Interract = data.get("Interract")
		CamF = data.get("CamFency")
		CamPL = data.get("CamPanLoduwka")
		CamT = data.get("CamToasty")
	file.close()
