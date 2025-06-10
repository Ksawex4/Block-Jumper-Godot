extends CharacterBody2D

@export var speed = 150
@export var jumpHeight = 380
@export var leftKey := "FencyLeft"
@export var rightKey := "FencyRight"
@export var jumpKey := "FencyJump"
@export var gravityDifference := 0
@export var WhosHp := "FencyHP"
@export var WhosMaxHp := "FencyMaxHP"
@export var stick := "FStick"
@export var who := "Fency"
var hasLeftAnimation
var stickInstance
var stickSpawnCooldown := 0.0
var DefaultHpBarLenght
var left = KEY_A
var right = KEY_D
var jump = KEY_W

func _ready() -> void:
	if Global.loadPos:
		global_position = Vector2(Global.loadPositionX, Global.loadPositionY)
		print(str(Global.loadPositionX))
		print(str(Global.loadPositionY))
		print(str(global_position))
	$SolidsCollision.disabled = true
	hasLeftAnimation = $AnimatedSprite2D.sprite_frames.has_animation("walkLeft")
	$AnimatedSprite2D.play("default")
	DefaultHpBarLenght = $Control/HP.size.x
	updateBar()
	if Global.get(stick):
		spawnStick()
	for x in range(5):
		await get_tree().physics_frame
	updateKeys()
	$SolidsCollision.disabled = false
	Global.loadPos = false
	
	BobSpawn.TotalBobs = 0 # Bob change room reset

func _physics_process(_delta: float) -> void:
	updateKeys()
	if Global.SolidBoxes:
		$CharacterBody2D/PlayerCollision.disabled = false
	else:
		$CharacterBody2D/PlayerCollision.disabled = true
	
	if hasLeftAnimation:
		if velocity.x > 0 && $AnimatedSprite2D.animation != "walkRight":
			$AnimatedSprite2D.play("walkRight")
		elif velocity.x < 0 && $AnimatedSprite2D.animation != "walkLeft":
			$AnimatedSprite2D.play("walkLeft")
		elif velocity.x == 0 && $AnimatedSprite2D.animation != "default":
			$AnimatedSprite2D.play("default")
	
	if who == "Fency" && TOASTS.WhoDuck == 1 or TOASTS.WhoDuck == 4 && who == "Fency" or TOASTS.WhoDuck == 4 && who == "PanLoduwka":
		$Duck2D.texture = load("res://Textures/Quack.jpg")
		$AnimatedSprite2D.visible = false
	if who == "PanLoduwka" && TOASTS.WhoDuck == 2:
		$Duck2D.texture = load("res://Textures/Quack.jpg")
		$AnimatedSprite2D.visible = false
	if who == "Toasty" && TOASTS.WhoDuck == 3 or TOASTS.WhoDuck == 4 && who == "Toasty":
		$Duck2D.texture = load("res://Textures/Quack.jpg")
		$AnimatedSprite2D.visible = false
	
	if Global.get(WhosHp) <= 0:
		queue_free()
	
	if stickSpawnCooldown > 0.0:
		stickSpawnCooldown -= 0.1
	
	if !stickInstance && Global.get(stick) && stickSpawnCooldown <= 0.0:
		spawnStick()
	
	if !is_on_floor():
		velocity.y += Global.Gravity + gravityDifference
	
	if Input.is_key_pressed(jump) && is_on_floor() && !Global.IsTypingInChat:
		velocity.y = -jumpHeight
	
	var axis = 0
	if Input.is_key_pressed(left):
		axis = -1
	if Input.is_key_pressed(right):
		axis = 1
	if Input.is_key_pressed(left) && Input.is_key_pressed(right):
		axis = 0
	
	if !Global.IsTypingInChat:
		velocity.x = speed * axis
	
	move_and_slide()

func _on_hit_box_area_body_entered(body: Node2D) -> void:
	hurt(body.get("damage"))
	if body.scene_file_path != "res://Scenes/Objects/spamguys.tscn":
		body.queue_free()

func hurt(damage):
	var HP = Global.get(WhosHp) - damage
	Global.set(WhosHp, HP)
	print (WhosHp + ": " + str(HP))
	if Global.FencyHP <= 0 && Global.PanLoduwkaHP <= 0 && Global.ToastyHP <= 0:
		Input.action_press("Quit")
	updateBar()

func updateBar():
	var HP = Global.get(WhosHp)
	var MaxHP = Global.get(WhosMaxHp)
	var Bob = float(HP) / MaxHP
	if HP > MaxHP:
		Global.set(WhosHp, MaxHP)
	$Control/HP.size.x = DefaultHpBarLenght * Bob
	if HP < MaxHP:
		$Control/Label.text = str(HP) + " / " + str(MaxHP)
	else:
		$Control/Label.text = str(HP)

func spawnStick():
	stickSpawnCooldown = 0.3
	var scene = get_tree().current_scene
	if stickInstance:
		stickInstance.queue_free()
	stickInstance = preload("res://Scenes/Objects/stick.tscn").instantiate()
	scene.add_child.call_deferred(stickInstance)
	stickInstance.who = str(who)
	stickInstance.stick = stick
	if get_tree().current_scene.scene_file_path == "res://Scenes/main_menu.tscn":
		stickInstance.visible = false

func updateKeys():
	var letters = "F"
	if who == "PanLoduwka":
		letters = "PL"
	elif who == "Toasty":
		letters = "T"
	left = Keys.get(letters + "Left")
	right = Keys.get(letters + "Right")
	jump = Keys.get(letters + "Jump")
