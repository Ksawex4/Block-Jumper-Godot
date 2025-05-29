extends CharacterBody2D

var damage = 100
const movementSpeed = 50

@export var goal: Node = null
@export var who = "Fency"

func _ready() -> void:
	$NavigationAgent2D.target_position = goal.global_position

func _physics_process(delta: float) -> void:
	if !FileAccess.file_exists("user://sól"):
		queue_free()
	
	if !$NavigationAgent2D.is_target_reached():
		var navPointDirection = to_local($NavigationAgent2D.get_next_path_position()).normalized()
		velocity = navPointDirection * movementSpeed
		$Sprite2D.rotation = velocity.angle()
		move_and_slide()

func _on_timer_timeout() -> void:
	if get_tree().current_scene.has_node(who):
		if $NavigationAgent2D.target_position != goal.global_position:
			$NavigationAgent2D.target_position = goal.global_position
	$Timer.start(1)
