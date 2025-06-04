extends CharacterBody2D

var isColliding = false
var save = false

func _ready() -> void:
	$AnimatedSprite2D.play("Idle")

func _process(_delta: float) -> void:
	if isColliding && Input.is_key_pressed(Keys.Interract):
		$AnimatedSprite2D.play("Save")
	if save:
		save = false
		Global.saveGame(global_position)
		$AudioStreamPlayer.play()

func _on_area_2d_body_entered(_body: Node2D) -> void:
	isColliding = true

func _on_area_2d_body_exited(_body: Node2D) -> void:
	isColliding = false

func _on_animated_sprite_2d_animation_finished() -> void:
	save = true


func _on_audio_stream_player_finished() -> void:
	$AnimatedSprite2D.play("Idle")
