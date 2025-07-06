extends CharacterBody2D

var who = "Fency"
var stick = "FStick"

func _ready() -> void:
	if !Global.playerAchievements.has("[img]res://Textures/Achievements/Stick.png[/img]") && !Global.CheatMode:
		Global.playerAchievements.append("[img]res://Textures/Achievements/Stick.png[/img]")

func _process(_delta: float) -> void:
	var scene = get_tree().current_scene
	if scene.has_node(who):
		position = scene.get_node(who).position
		if !Global.get(stick):
			queue_free()
	else:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("stick: body entered: " + str(body), "\nRemoving Enemy")
	if body.scene_file_path == "res://Scenes/Objects/kill_block.tscn" && !Global.playerAchievements.has("[img]res://Textures/Achievements/BlockKiller.png[/img]") && !Global.CheatMode:
		Global.playerAchievements.append("[img]res://Textures/Achievements/BlockKiller.png[/img]")
	if body.scene_file_path == "res://Scenes/Objects/spamguys.tscn" && !Global.playerAchievements.has("[img]res://Textures/Achievements/SpamKiller.png[/img]") && !Global.CheatMode:
		Global.playerAchievements.append("[img]res://Textures/Achievements/SpamKiller.png[/img]")
	body.queue_free()
	Global.set(stick, false)
	queue_free()
