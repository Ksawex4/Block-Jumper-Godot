extends Node

var SpawnPos = 3855977
var TotalBobs = 0
var SavedBobs = 0
var Glitching = false
var Songs = ["souMainMenu.wav", "souTrash.wav", "souZworkaSong.wav"]
var SongsCreate = false

func _ready() -> void:
	if FileAccess.file_exists("user://The Bobs have awoken.BOB"):
		var file = FileAccess.open("user://The Bobs have awoken.BOB", FileAccess.READ)
		var jsonString = file.get_as_text()
		var data = JSON.parse_string(jsonString)
		SavedBobs = data.get("BOB")
	print("BobSpawn: Saved Bobs =", SavedBobs)

func _process(delta: float) -> void:
	if SavedBobs == 6:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	if TotalBobs < 1 && SavedBobs > 0:
		SongsCreate = true
	if SavedBobs >= 1: # BOB BOB BOB BOB BOB BOB BOB BOB BOB BOB BOB BOB BOB BOB, This Bob is not finished yet beacuse IM TAKING TOO LONG
		SpawnPos = 385597
	var FY
	var PLY
	var TY
	if get_tree().current_scene != null:
		if TotalBobs < SavedBobs && !SavedBobs == 6:
			spawnBob()
			print("BobSpawn: Spawned Bob from save")
		if get_tree().current_scene.has_node("Fency"):
			FY = get_tree().current_scene.get_node("Fency").position.y
		if get_tree().current_scene.has_node("PanLoduwka"):
			PLY = get_tree().current_scene.get_node("PanLoduwka").position.y
		if get_tree().current_scene.has_node("Toasty"):
			TY = get_tree().current_scene.get_node("Toasty").position.y
		if get_tree().current_scene.scene_file_path != "res://Scenes/main_menu.tscn" && !Glitching:
			if FY != null :
				if FY >= SpawnPos:
					print("BobSpawn: Fency reached y ", SpawnPos, " added 1 Bob")
					Glitching = true
					SpawnPos = 9999999999999999
					spawnBob()
					SaveBOB()
					get_tree().paused = true
					var sound = load("res://SoundEffects/souCrash.ogg")
					var player = AudioStreamPlayer.new()
					player.stream = sound
					player.process_mode = Node.PROCESS_MODE_ALWAYS
					get_tree().current_scene.add_child(player)
					player.play()
					await get_tree().create_timer(3.0, true).timeout
					get_tree().quit()
			if PLY != null:
				if PLY >= SpawnPos:
					print("BobSpawn: PanLoduwka reached y ", SpawnPos, " added 1 Bob")
					Glitching = true
					SpawnPos = 9999999999999999
					spawnBob()
					SaveBOB()
					get_tree().paused = true
					var sound = load("res://SoundEffects/souCrash.ogg")
					var player = AudioStreamPlayer.new()
					player.stream = sound
					player.process_mode = Node.PROCESS_MODE_ALWAYS
					get_tree().current_scene.add_child(player)
					player.play()
					await get_tree().create_timer(3.0, true).timeout
					get_tree().quit()
			if TY != null:
				if TY >= SpawnPos:
					print("BobSpawn: Toasty reached y ", SpawnPos, " added 1 Bob")
					Glitching = true
					SpawnPos = 9999999999999999
					spawnBob()
					SaveBOB()
					get_tree().paused = true
					var sound = load("res://SoundEffects/souCrash.ogg")
					var player = AudioStreamPlayer.new()
					player.stream = sound
					player.process_mode = Node.PROCESS_MODE_ALWAYS
					get_tree().current_scene.add_child(player)
					player.play()
					await get_tree().create_timer(3.0, true).timeout
					get_tree().quit()
		if SavedBobs == 3:
			Global.Gravity = 0
		if get_tree().current_scene.has_node("Toasty") && SavedBobs == 3:
			get_tree().current_scene.get_node("Toasty").gravityDifference = 0
		if SavedBobs == 4 && SongsCreate:
			SongsCreate = false
			for bob in Songs:
				print(typeof(bob))
				var path = "res://Songs/" + bob
				var Song = load(path)
				if Song:
					var player = AudioStreamPlayer.new()
					player.stream = Song
					player.autoplay = true
					get_tree().current_scene.add_child(player)
					player.play()
					print("created audio stream with song " + path)
		if SavedBobs == 5:
			if get_tree().current_scene.has_node("Fency"):
				get_tree().current_scene.get_node("Fency").velocity += Vector2(randf_range(-50,50), randf_range(-150,150))
			if get_tree().current_scene.has_node("PanLoduwka"):
				get_tree().current_scene.get_node("PanLoduwka").velocity += Vector2(randf_range(-50,50), randf_range(-150,150))
			if get_tree().current_scene.has_node("Toasty"):
				get_tree().current_scene.get_node("Toasty").velocity += Vector2(randf_range(-50,50), randf_range(-150,150))
		
	

func SaveBOB():
	print("BobSpawn: Saved Bobs")
	if !Global.CheatMode && !Global.playerAchievements.has("[img]res://Textures/Achievements/BOB.png[/img]"):
		Global.playerAchievements.append("[img]res://Textures/Achievements/BOB.png[/img]")
		print("BobSpawn: Gave my achievement to player")
	Global.saveAchievements()
	startGlitch()
	if Global.SpeedrunMode:
		var speeeed = {
			"TimeF": Global.timerF + Global.timerS * 60 + Global.timerM * 60 * 60
		}
		var feli = FileAccess.open("user://TimeSave", FileAccess.WRITE)
		var jsan = JSON.stringify(speeeed)
		feli.store_string(jsan)
		feli.close()
	var struct = {
		"BOB": SavedBobs + 1
	}
	var file = FileAccess.open("user://The Bobs have awoken.BOB", FileAccess.WRITE)
	var jsonString = JSON.stringify(struct)
	file.store_string(jsonString)
	file.close()

func spawnBob():
	var buble = load("res://Scenes/Objects/bob.tscn").instantiate()
	get_tree().current_scene.add_child(buble)
	TotalBobs += 1

func startGlitch():
	for sans in get_tree().current_scene.get_children():
		Glitch(sans)

func Glitch(MyChild):
	if "position" in MyChild:
		MyChild.position += Vector2(randf_range(-100,100), randf_range(-100,100))
	if "rotation" in MyChild:
		MyChild.rotation = randf_range(-360,360)
