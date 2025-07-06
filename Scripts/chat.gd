extends Control

var isPrinting = false
var ChatName = "<[color=#3deaff]No[/color][color=ff9000]va[/color]>"
var SpawnObjects = {
	"Fency": load("res://Scenes/Objects/fency.tscn"),
	"PanLoduwka": load("res://Scenes/Objects/pan_loduwka.tscn"),
	"Toasty": load("res://Scenes/Objects/toasty.tscn"),
	"Bean": load("res://Scenes/Objects/bean.tscn"),
	"SavePoint": load("res://Scenes/Objects/save_point.tscn"),
	"TrashCan": load("res://Scenes/Objects/trash_can.tscn"),
	"BeanBlock": load("res://Scenes/Objects/bean_block.tscn"),
	"Chip": load("res://Scenes/Objects/chip.tscn"),
	"BadlyDrawnQueen": load("res://Scenes/Objects/badly_drawn_queen.tscn"),
	"Stick": load("res://Scenes/Objects/stick.tscn"),
	"Spamguys": load("res://Scenes/Objects/spamguys.tscn"),
	"KillBlock": load("res://Scenes/Objects/kill_block.tscn"),
	"FlyThing": load("res://Scenes/Objects/fly_thing.tscn"),
}

func _process(_delta: float) -> void:
	$Chat.text = Global.chat

func _on_input_editing_toggled(toggled_on: bool) -> void:
	Global.IsTypingInChat = toggled_on

func _on_input_text_submitted(new_text: String) -> void:
	if !new_text.begins_with("/"):
		SendMessage("<" + Global.FollowWho + "> ", new_text)
	else:
		processCommand(new_text)
	$Input.text = ""

func SendMessage(Name: String, text: String) -> void:
	Global.chat += "\n" + Name + text

func processCommand(text):
	var argsPart = ""
	var args = []
	var command = ""
	if text.find(" ") != -1:
		command = text.substr(0, text.find(" "))
		argsPart = text.substr(text.find(" ") + 1)
		args = argsPart.split(" ")
	else:
		command = text
	print("chat: Processed Command: \n command: ", command, "\n args: ", args)
	
	if !Global.CheatMode && command != "/CheatMode":
		SendMessage(ChatName, "Cheat Mode is Disabled, to turn on Cheats, type: \"/CheatMode\"\n
		You won't be able to get any more Achievements and your save Will be Deleted if you want to disable Cheats")
	if command == "/CheatMode":
		Global.CheatMode = true
		SendMessage(ChatName, 'Cheat Mode Enabled, You Can No Longer Get Achievements, To Turn Off Cheats, Type: "/Reset"\n
		WARNING, This will delete your save!')
		return
	
	if Global.CheatMode:
		executeCommand(args, command)

func executeCommand(args, command):
	match command:
		"/clear":
			Global.chat = ""
		"/spawn":
			if args.size() >= 1:
				if SpawnObjects.has(args[0]):
					var object = SpawnObjects.get(args[0]).instantiate()
					var scene = get_tree().current_scene
					object.position = scene.get_node(Global.FollowWho).position
					scene.add_child(object)
					SendMessage(ChatName, "Spawned " + args[0])
				else:
					SendMessage(ChatName, "can't spawn this object")
			else:
				SendMessage(ChatName, "Not enough arguments")
		"/playerCollision":
			if !Global.SolidBoxes:
				Global.SolidBoxes = true
				SendMessage(ChatName, "players can collide with eachother")
			else:
				Global.SolidBoxes = false
				SendMessage(ChatName, "players can no longer collide with eachother")
		"/Reset":
			if FileAccess.file_exists("user://save.bj"):
				DirAccess.remove_absolute("user://save.bj")
				print("chat: Deleted the save file")
			if FileAccess.file_exists("user://The Bobs have awoken.BOB"):
				DirAccess.remove_absolute("user://The Bobs have awoken.BOB")
				print("chat: Deleted the BOB file")
			get_tree().quit()
		_:
			SendMessage(ChatName, "Command " + command + " doesn't exist") 
