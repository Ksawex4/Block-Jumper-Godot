extends CharacterBody2D

@export var speed = 150
@export var jumpHeight = 380
@export var leftKey = "FencyLeft"
@export var rightKey = "FencyRight"
@export var jumpKey = "FencyJump"
@export var gravityDifference = 0
@export var WhosHp = "FencyHP"

func _physics_process(delta: float) -> void:
	if Global.get(WhosHp) <= 0:
		queue_free()
	
	if !is_on_floor():
		velocity.y += Global.Gravity + gravityDifference
	
	if Input.is_action_pressed(jumpKey):
		jump()
	
	var horizontalDirection = Input.get_axis(leftKey, rightKey)
	move(horizontalDirection)
	
	move_and_slide()

func jump():
	if is_on_floor():
		velocity.y = -jumpHeight

func move(x):
	velocity.x = speed * x


func _on_hit_box_area_body_entered(body: Node2D) -> void:
	var hit = body.get(damage)
	hurt(hit)

func hurt(damage):
	var HP = Global.get(WhosHp)
	HP = HP - damage
	Global.set(WhosHp, HP)
