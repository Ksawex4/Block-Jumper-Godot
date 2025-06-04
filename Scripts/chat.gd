extends Control

var isPrinting = false

func _process(delta: float) -> void:
	$Chat.text = Global.chat

func _on_input_editing_toggled(toggled_on: bool) -> void:
	Global.IsTypingInChat = toggled_on

func _on_input_text_submitted(new_text: String) -> void:
	QueueMessage("<" + Global.FollowWho + "> ", new_text)
	$Input.text = ""

func QueueMessage(Name: String, text: String) -> void:
	print("Queued message: \n" + text + "\nby " + Name)
	var message = Name + text
	Global.QueuedMessages.append(message)
	if !isPrinting:
		ProcessQueue()

func SendMessage(message):
	Global.chat += "\n"
	if message.length() <= Global.ChatInstantSend:
		for x in message:
			Global.chat += x
			await get_tree().process_frame
		return
	else:
		Global.chat += message

func ProcessQueue():
	if Global.QueuedMessages.size() == 0:
		isPrinting = false
		return
	isPrinting = true
	await SendMessage(Global.QueuedMessages.pop_front())
	ProcessQueue()
