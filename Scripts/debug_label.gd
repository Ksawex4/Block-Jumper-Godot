extends RichTextLabel

var startText = "BOB"

func _ready() -> void:
	startText = text

func _process(delta: float) -> void:
	if visible:
		var SCEEEENE = get_tree().current_scene
		text = startText
		if SCEEEENE.has_node("Fency"):
			var Fency = SCEEEENE.get_node("Fency")
			text = text.replace("POF", str(Fency.position)).replace("VEF", str(Fency.velocity)).replace("FHEP", str(Global.FencyHP)).replace("FMHELP", str(Global.FencyMaxHP))
		if SCEEEENE.has_node("PanLoduwka"):
			var PL = SCEEEENE.get_node("PanLoduwka")
			text = text.replace("POPL", str(PL.position)).replace("VEPL", str(PL.velocity)).replace("PLHEP", str(Global.PanLoduwkaHP)).replace("PLMNYEH", str(Global.PanLoduwkaMaxHP))
		if SCEEEENE.has_node("Toasty"):
			var Toast = SCEEEENE.get_node("Toasty")
			text = text.replace("POT", str(Toast.position)).replace("VOT", str(Toast.velocity)).replace("TOASTTHISHAP", str(Global.ToastyHP)).replace("MAXEDTOASTING", str(Global.ToastyMaxHP))
		text = text.replace("RAM", SCEEEENE.name).replace("NODERS", str(HowManyNodesHere())).replace("GIVEMEBEANS", str(Global.Beans)).replace("CHIEEEP", str(Global.gotChip)).replace("SHIEET", Global.FollowWho).replace("SACHTS", str(Global.shownAchievements)).replace("PLACHTS", str(Global.playerAchievements))
		text = text.replace("DUCK", str(TOASTS.TOAST))
func HowManyNodesHere():
	var count = 0
	var queue = [get_tree().current_scene]
	while queue.size() > 0:
		var current = queue.pop_front()
		count += 1
		for child in current.get_children():
			queue.append(child)
	return count
