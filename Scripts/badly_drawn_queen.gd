extends CharacterBody2D

var who = "Fency"
var texter = 0
var texta = " Get That Chip"
var texta2 = "Sodium Chloride"

func _ready() -> void:
	if TOASTS.IsSpamming:
		$Sprite2D.texture = load("res://Textures/Spamguys/BadlyDrawnSpamton.png")
		texta = " GET THAT [Microchip]"
		texta2 = "DELICIS CHIP"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if texter == 0:
		who = body.name
		var text = who + texta
		for x in text:
			$Label.text += x
			await get_tree().process_frame
		if texter == 0:
			texter = 1
	if texter == 1 && Global.gotChip:
		if !Global.playerAchievements.has("[img]res://Textures/Achievements/Chip.png[/img]"):
			Global.playerAchievements.append("[img]res://Textures/Achievements/Chip.png[/img]")
		var text = texta2
		texter += 1
		$Label.text = ""
		for x in text:
			$Label.text += x
			await get_tree().process_frame
