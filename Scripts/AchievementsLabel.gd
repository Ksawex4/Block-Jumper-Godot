extends RichTextLabel

var normalText := "[color=yellow]Your current achievements ACH/4:[/color]"

func _on_timer_timeout() -> void:
	text = normalText.replace("ACH", str(Global.playerAchievements.size()))
	for x in Global.playerAchievements:
		text += "\n" + x
	$Timer.start(10)
