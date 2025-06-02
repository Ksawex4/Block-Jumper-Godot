extends Node2D

@export var texture = "res://Textures/Backgrounds/Background1.png"
@export var Scale = Vector2(2.0, 2.0)

func _ready() -> void:
	$ParallaxBackground/ParallaxLayer/Sprite2D.scale = Scale
	$ParallaxBackground/ParallaxLayer/Sprite2D.texture = load(texture)
	var img = Image.new()
	var Bob = img.load(texture)
	if Bob == OK:
		$ParallaxBackground/ParallaxLayer.motion_mirroring = Vector2(img.get_width() * Scale.x, img.get_height() * Scale.y)
