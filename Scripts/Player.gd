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
	$SolidsCollision.disabled = false
	Global.loadPos = false

func _physics_process(_delta: float) -> void:
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
	if Global.get(WhosHp) <= 0:
		queue_free()
	
	if stickSpawnCooldown > 0.0:
		stickSpawnCooldown -= 0.1
	
	if !stickInstance && Global.get(stick) && stickSpawnCooldown <= 0.0:
		spawnStick()
	
	if !is_on_floor():
		velocity.y += Global.Gravity + gravityDifference
	
	if Input.is_action_pressed(jumpKey) && is_on_floor():
		velocity.y = -jumpHeight
	
	velocity.x = speed * Input.get_axis(leftKey, rightKey)
	
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
