extends Control

var watKey = ""
var waitingForInput = false

func _process(_delta: float) -> void:
	$FLeft.text = "FencyLeft: " + str(OS.get_keycode_string(Keys.FLeft))
	$FRight.text = "FencyRight: " + str(OS.get_keycode_string(Keys.FRight))
	$FJump.text = "FencyJump: " + str(OS.get_keycode_string(Keys.FJump))
	$PLLeft.text = "PanLoduwkaLeft: " + str(OS.get_keycode_string(Keys.PLLeft))
	$PLRight.text = "PanLoduwkaRight: " + str(OS.get_keycode_string(Keys.PLRight))
	$PLJump.text = "PanLoduwkaJump: " + str(OS.get_keycode_string(Keys.PLJump))
	$TLeft.text = "ToastyLeft: " + str(OS.get_keycode_string(Keys.TLeft))
	$TRight.text = "ToastyRight: " + str(OS.get_keycode_string(Keys.TRight))
	$TJump.text = "ToastyJump: " + str(OS.get_keycode_string(Keys.TJump))
	$Interract.text = "Interract: " + str(OS.get_keycode_string(Keys.Interract))
	$CamF.text = "CamFency: " + str(OS.get_keycode_string(Keys.CamF))
	$CamPL.text = "CamPanLoduwka: " + str(OS.get_keycode_string(Keys.CamPL))
	$CamT.text = "CamToasty: " + str(OS.get_keycode_string(Keys.CamT))

func _input(event: InputEvent) -> void:
	if event is InputEventKey && event.pressed && waitingForInput:
		if TOASTS.TOAST != 16:
			Keys.set(watKey, event.keycode)
		else:
			TOASTS.usedKeys.erase(Keys.get(watKey))
			Keys.set(watKey, TOASTS.randKey())
		waitingForInput = false
		$INFO.visible = false
		if TOASTS.TOAST != 16:
			Keys.SaveKeys()

func _on_f_left_pressed() -> void:
	watKey = "FLeft"
	waitingForInput = true
	$INFO.visible = true

func _on_f_right_pressed() -> void:
	watKey = "FRight"
	waitingForInput = true
	$INFO.visible = true

func _on_f_jump_pressed() -> void:
	watKey = "FJump"
	waitingForInput = true
	$INFO.visible = true

func _on_pl_left_pressed() -> void:
	watKey = "PLLeft"
	waitingForInput = true
	$INFO.visible = true

func _on_pl_right_pressed() -> void:
	watKey = "PLRight"
	waitingForInput = true
	$INFO.visible = true

func _on_pl_jump_pressed() -> void:
	watKey = "PLJump"
	waitingForInput = true
	$INFO.visible = true

func _on_t_left_pressed() -> void:
	watKey = "TLeft"
	waitingForInput = true
	$INFO.visible = true

func _on_t_right_pressed() -> void:
	watKey = "TRight"
	waitingForInput = true
	$INFO.visible = true

func _on_t_jump_pressed() -> void:
	watKey = "TJump"
	waitingForInput = true
	$INFO.visible = true

func _on_interract_pressed() -> void:
	watKey = "Interract"
	waitingForInput = true
	$INFO.visible = true

func _on_cam_f_pressed() -> void:
	watKey = "CamF"
	waitingForInput = true
	$INFO.visible = true

func _on_cam_pl_pressed() -> void:
	watKey = "CamPL"
	waitingForInput = true
	$INFO.visible = true

func _on_cam_t_pressed() -> void:
	watKey = "CamT"
	waitingForInput = true
	$INFO.visible = true
