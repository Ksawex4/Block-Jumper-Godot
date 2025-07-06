extends CharacterBody2D

var who = "Fency"
var texter = -1
var text = ["Get That Chip", "Sodium Chloride"]
@export var SecretQueen = false
var SecretText = ["Hello PLAYER, what are you doing here?", "I guess it doesn't matter", "So congrats, You found me"]
var InterractDelay = false

func _ready() -> void:
	if BobSpawn.SavedBobs == 6:
		print("Queen: Died beacuse 'BobSpawn.SavedBobs == 6'")
		queue_free()
	if TOASTS.IsSpamming && !SecretQueen:
		print("Queen: Changed sprite to Spamton beacuse TOAST is 28")
		$Sprite2D.texture = load("res://Textures/Spamguys/BadlyDrawnSpamton.png")
		text = ["GET THAT [Microchip]", "DELICIS CHIP"]

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !SecretQueen:
		if texter == -1:
			who = body.name
			var texte = who + text[0]
			for x in texte:
				$Label.text += x
				await get_tree().process_frame
			if texter == -1:
				texter = 0
		if texter == 0 && Global.gotChip:
			if !Global.playerAchievements.has("[img]res://Textures/Achievements/Chip.png[/img]") && !Global.CheatMode:
				print("Queen: Gave my achievement to the player")
				Global.playerAchievements.append("[img]res://Textures/Achievements/Chip.png[/img]")
			texter += 1
			$Label.text = ""
			for x in text[1]:
				$Label.text += x
				await get_tree().process_frame
	else:
		if Input.is_key_pressed(Keys.Interract) && !InterractDelay:
			$Label.text = ""
			InterractDelay = true
			texter += 1
			var username = OS.get_environment("USER")
			if username == "":
				username = OS.get_environment("USERNAME")
			if texter < SecretText.size() && !Global.CheatMode:
				var MyText = SecretText[texter].replace("PLAYER", username)
				for x in MyText:
					$Label.text += x
					await get_tree().process_frame
			elif Global.CheatMode && texter == 0:
				for x in "Come back here without Cheat Mode":
					$Label.text += x
					await get_tree().process_frame
			await get_tree().create_timer(0.3).timeout
			InterractDelay = false
