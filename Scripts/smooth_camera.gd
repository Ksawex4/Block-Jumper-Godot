extends Camera2D

var achievement = ""
var ppos = Vector2(-355, 200)
var hiddden = true
var MaxSmoothSpeed = 1000
var Debug = false

func _process(_delta: float) -> void:
	if Global.SpeedrunMode:
		var timer
		Global.timerF += 1
		if Global.timerF >= 60:
			Global.timerS += 1
			Global.timerF -= 60
		if Global.timerS >= 60:
			Global.timerM += 1
			Global.timerS -= 60
		if Global.timerF >= 1 or Global.timerS >= 1:
			timer = str(Global.timerS) + ":" + str(Global.timerF)
		if Global.timerM >= 1:
			timer = str(Global.timerM) + ":" + str(Global.timerS) + ":" + str(Global.timerF)
		if !Global.playerAchievements.size() >= 5:
			$SpeedrunLabel.text = timer
	
	if Debug && !$DebugLabel.visible:
		$DebugLabel.visible = true
	elif !Debug && $DebugLabel.visible:
		$DebugLabel.visible = false
	var scene = get_tree().current_scene
	var node = scene.get_node_or_null(Global.FollowWho)
	
	if Input.is_action_just_pressed("DebugLabel"):
		if Debug:
			Debug = false
		else:
			Debug = true
	
	if node != null:
		if node.velocity.x > MaxSmoothSpeed or node.velocity.y > MaxSmoothSpeed:
			position = node.position
		else:
			position.x = lerp(position.x, node.position.x, 0.1)
			position.y = lerp(position.y, node.position.y, 0.1)
		if TOASTS.rigid:
			rotation = node.rotation
	
	if Input.is_key_pressed(Keys.CamF) && scene.has_node("Fency"):
		Global.FollowWho = "Fency"
	elif Input.is_key_pressed(Keys.CamPL) && scene.has_node("PanLoduwka"):
		Global.FollowWho = "PanLoduwka"
	elif Input.is_key_pressed(Keys.CamT) && scene.has_node("Toasty"):
		Global.FollowWho = "Toasty"
	
	#Achievements Label
	if $AchievementsLabel.position != ppos:
		$AchievementsLabel.position = lerp($AchievementsLabel.position, ppos, 0.1)
	
	for ach in Global.playerAchievements:
		if !Global.shownAchievements.has(ach) && hiddden:
			showAchievement(ach)
			Global.shownAchievements.append(ach)
			break

func showAchievement(ach):
	Global.saveAchievements()
	hiddden = false
	ppos = Vector2(-355, -200)
	$AchievementsLabel.text = ach
	$AudioStreamPlayer.stream = load((Global.AchSound))
	if Global.AchSound == "res://SoundEffects/souTOASTAch.wav":
		$AudioStreamPlayer.volume_db = 30
	$AudioStreamPlayer.play()
	await get_tree().create_timer(4.0).timeout
	ppos = Vector2(-491, -200)
	await get_tree().create_timer(1.0).timeout
	$AchievementsLabel.text = ""
	hiddden = true
