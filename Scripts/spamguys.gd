extends CharacterBody2D

var damage = 50
var speed = 100
var direction := 1
var wallCooldown := 0.0

func _ready() -> void:
	var rand = randi_range(0,3)
	if !Global.playerAchievements.has("[img]res://Textures/Achievements/Trash.png[/img]"):
		Global.playerAchievements.append("[img]res://Textures/Achievements/Trash.png[/img]")
	if rand == 0:
		$BadlyDrawnSpamton.disabled = false
		$Sprite2D.texture = load("res://Textures/Spamguys/BadlyDrawnSpamton.png")
		speed = 70
	if rand == 1:
		$Brunton1.disabled = false
		$Sprite2D.texture = load("res://Textures/Spamguys/Brunton1.png")
		speed = 130
	if rand == 2:
		$Brunton2.disabled = false
		$Sprite2D.texture = load("res://Textures/Spamguys/Brunton2.png")
		speed = 130
	if rand == 3:
		$Ksawton.disabled = false
		$Sprite2D.texture = load("res://Textures/Spamguys/Ksawton.png")
		speed = 100

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += Global.Gravity
	velocity.x = speed * direction
	if is_on_wall() && wallCooldown <= 0.0:
		wallCooldown = 0.2
		direction *= -1
	move_and_slide()
	if wallCooldown > 0.0:
		wallCooldown -= 0.1
