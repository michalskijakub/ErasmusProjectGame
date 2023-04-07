extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func update_bar1(value):
	#$Tween.remove_all()
	#$Tween.interpolate_property($House1Progress, "value", null, int(value), 0.25)
	#$Tween.start()
	$House1Progress.value = value

func update_bar2(value):
	#$Tween.remove_all()
	#$Tween.interpolate_property($House2Progress, "value", null, int(value), 0.25)
	#$Tween.start()
	$House2Progress.value = value
