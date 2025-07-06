extends Node

var TOAST = -1
var ToastOn = false

var UsableKeys = [KEY_Q, KEY_W, KEY_E, KEY_R, KEY_T, KEY_Y, KEY_U, KEY_I, KEY_O, KEY_P,
KEY_A, KEY_S, KEY_D, KEY_F, KEY_G, KEY_H, KEY_J, KEY_K, KEY_L, KEY_Z, KEY_X, KEY_C, KEY_V, KEY_B, KEY_N,
KEY_0, KEY_1, KEY_2, KEY_3, KEY_4, KEY_5, KEY_6, KEY_7, KEY_8, KEY_9, KEY_ALT, KEY_TAB, KEY_SPACE, KEY_BACKSLASH,
KEY_DOWN, KEY_LEFT, KEY_RIGHT,KEY_UP, KEY_F1, KEY_F2, KEY_F3, KEY_F4, KEY_F5,
KEY_F6, KEY_F7, KEY_F9, KEY_F10, KEY_F11, KEY_F12]
var usedKeys = []
var IsSpamming = false
var WhoDuck = -1
var rigid = false

func _process(delta: float) -> void:
	if FileAccess.file_exists("user://notVeryRandomToast.txt"): #Will disable achievements in the future or will be removed
		var file = FileAccess.open("user://notVeryRandomToast.txt", FileAccess.READ)
		TOAST = int(file.get_as_text())
		file.close()
	if TOAST == -1 && get_tree().current_scene.scene_file_path != "res://Scenes/MainMenu.tscn":
		TOAST = randi_range(1,100)
	if !ToastOn:
		ToastOn = true
		getTheToastEvent()

func getTheToastEvent():
	if TOAST == 4:
		Global.AchSound = "res://SoundEffects/souTOASTAch.wav"
	if TOAST == 16:
		Keys.FLeft = randKey()
		Keys.FRight = randKey()
		Keys.FJump = randKey()
		Keys.PLLeft = randKey()
		Keys.PLRight = randKey()
		Keys.PLJump = randKey()
		Keys.TLeft = randKey()
		Keys.TRight = randKey()
		Keys.TJump = randKey()
		Keys.Interract = randKey()
		Keys.CamF = randKey()
		Keys.CamPL = randKey()
		Keys.CamT = randKey()
	if TOAST == 28:
		IsSpamming = true
	if TOAST == 37:
		WhoDuck = randi_range(1,4)
	if TOAST == 54:
		rigid = true # UNFINISHED

func randKey():
	var IntKey = randi_range(0, UsableKeys.size() - 1)
	while usedKeys.has(UsableKeys[IntKey]):
		IntKey = randi_range(1, UsableKeys.size())
	usedKeys.append(UsableKeys[IntKey])
	return UsableKeys[IntKey]
