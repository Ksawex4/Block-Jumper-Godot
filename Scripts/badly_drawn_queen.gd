extends CharacterBody2D

var who = "Fency"
var texter = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if texter == 0:
		who = body.name
		var text = who + " Get The Chip"
		for x in text:
			$Label.text += x
		if texter == 0:
			texter = 1
	if texter == 1 && Global.gotChip:
		if !Global.playerAchievements.has("[img]res://Textures/Achievements/Chip.png[/img]"):
			Global.playerAchievements.append("[img]res://Textures/Achievements/Chip.png[/img]")
		var text = "Sodium Chloride"
		texter += 1
		$Label.text = ""
		for x in text:
			$Label.text += x
