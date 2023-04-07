extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("default")


func _on_Area2D_body_entered(body):
	if "ThrowableObject" in body.name:
		$CatHiss.play()
		$AnimatedSprite.play("hiss")
	print(body.name)


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation != "default":
		$AnimatedSprite.play("default")
