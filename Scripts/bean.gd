extends CharacterBody2D

@export var value = 1

func _ready() -> void:
	if TOASTS.TOAST == 49:
		print("Bean: Changed sprite to Toast beacuse 'TOAST == 49'")
		$AnimatedSprite2D.animation = "Toast"
	else:
		var rander = randi_range(1,5)
		$AnimatedSprite2D.animation = "Bean" + str(rander)
	$AnimatedSprite2D.play()

func _physics_process(_delta: float) -> void:
	velocity.y += Global.Gravity
	move_and_slide()

func _on_area_2d_body_entered(_body: Node2D) -> void:
	queue_free()
	Global.Beans += value
	print("Bean: Collected, Beans: ", Global.Beans)
