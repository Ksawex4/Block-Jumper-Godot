extends CharacterBody2D

var Speed = 90
var direction = 1
var wallCooldown = 0.0

func _process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += Global.Gravity
	if is_on_floor():
		velocity.y = -randi_range(40,450                                                                                                                                                                                                                                                                                                                                                                                                                                                                               )
	velocity.x = Speed * direction
	if is_on_wall() && wallCooldown <= 0.0:
		wallCooldown = 0.2
		direction *= -1
	if wallCooldown > 0.0:
		wallCooldown -= 0.1
	move_and_slide()
