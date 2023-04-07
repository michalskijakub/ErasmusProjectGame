extends Node2D

onready var text_node = $Anchor/RichTextLabel
onready var text_bg = $Anchor/ColorRect

const char_time = 0.04
const margin_offset = 16

var use_timer = false

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	#set_text("Waarom zijn\n bananen krom? Ze groeien naar de zon.") #test

func set_text(text, wait_time = 0):
	# reset margin_bottom
	text_bg.margin_bottom = 84
	text_node.margin_bottom = 128
	
	visible = true
	
	$Timer.stop()
	if wait_time != 0:
		$Timer.wait_time = wait_time
		use_timer = true
	else:
		use_timer = false
	
	text_node.bbcode_text = text
	
	# Duration
	var duration = text_node.text.length() * char_time
	
	# set text size of speech bubble
	var text_size = text_node.get_font("normal_font").get_string_size(text_node.text)
	text_node.margin_right = text_size.x + margin_offset
	text_bg.margin_right = text_size.x + margin_offset
	
	if "\n" in text:
		var amountoflines = text.count("\n") + 1
		text_bg.margin_bottom = text_bg.margin_bottom * amountoflines
		text_node.margin_bottom = text_node.margin_bottom * amountoflines
		
		var breakchar: float = text.find("\n") + 1
		var end: float = text.length() - breakchar + 1
		
		if end > breakchar: 
			text_size.x = text_size.x * ((end / text.length()))
		else:
			text_size.x = text_size.x * ((breakchar / text.length()))
		
		#Animation
		$Tween.remove_all()
		$Tween.interpolate_property(text_node, "percent_visible", 0, 1, duration)
		$Tween.interpolate_property(text_bg, "margin_right", 0, text_size.x + margin_offset, duration / 2)
		$Tween.start()
	
	else:
		#Animation
		$Tween.remove_all()
		$Tween.interpolate_property(text_node, "percent_visible", 0, 1, duration)
		$Tween.interpolate_property(text_bg, "margin_right", 0, text_size.x + margin_offset, duration)
		$Tween.start()
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Tween_tween_all_completed():
	if use_timer == true:
		print("timer start")
		$Timer.start()


func _on_Timer_timeout():
	set_text("")
	#visible = false
