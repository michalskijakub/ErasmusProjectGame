extends Node2D


var is_grabbed


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	if is_grabbed:
		$Old.hide()
		$Empty.show()
