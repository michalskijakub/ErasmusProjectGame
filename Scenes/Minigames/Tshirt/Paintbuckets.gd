extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func greyout_buckets():
	$Yellow.modulate = '#404040'
	$Green.modulate = '#404040'
	$White.modulate = '#404040'
	$Red.modulate = '#404040'
	$Blue.modulate = '#404040'
	$Black.modulate = '#404040'
	
