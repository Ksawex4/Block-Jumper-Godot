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
		_:
			SendMessage(ChatName, "command " + command + " doesn't exist") 
