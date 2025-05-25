extends CharacterBody2D

@export var speed = 150
@export var jumpHeight = 380
@export var leftKey = "FencyLeft"
@export var rightKey = "FencyRight"
@export var jumpKey = "FencyJump"
@export var gravityDifference = 0

func _physics_process(delta: float) -> void:
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
