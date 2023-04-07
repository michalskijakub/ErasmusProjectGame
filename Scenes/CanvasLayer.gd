extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func show_message(text):
	$Message.text = "+" + str(text)
	
	if text == 0:
		$Message.add_color_override("font_color", Color(255,0,0))
	if text == 5:
		$Message.add_color_override("font_color", Color(255,255,255))
	if text == 10:
		$Message.add_color_override("font_color", Color(0,255,0))
	
	$AnimationPlayer.play("show_message")

