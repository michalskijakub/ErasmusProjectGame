extends Node2D

signal ask_question

var is_enabled = true
var times_switched = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.hide()
	$Lightbulb/Light2D.show()
	modulate = '#ffffff'
	$SpeechBubble.set_text("Dit licht hoeft niet aan te staan als er niemand is,\n doe het uit om energie te besparen!")


func _on_TextureButton_pressed():
	$SwitchSound.play()
	if is_enabled == true:
		is_enabled = false
		$Lightbulb/Light2D.hide()
		modulate = '#9f9f9f'
		$TextureButton/Lightswitch_off.show()
		$TextureButton/Lightswitch_on.hide()
		$SpeechBubble.set_text("Goed gedaan! ... \nIk zie alleen niks meer...")
		$Button.show()
		$Cat.play('default')
		times_switched += 1
	elif is_enabled == false:
		is_enabled = true
		$Lightbulb/Light2D.show()
		modulate = '#ffffff'
		$TextureButton/Lightswitch_off.hide()
		$TextureButton/Lightswitch_on.show()
		$SpeechBubble.set_text('Je kan het licht beter uit laten staan.')
		$Cat.play('hiss')
		$Button.hide()
		times_switched += 1
	
	if times_switched == 5:
		$SpeechBubble.set_text('Nu zit je me gewoon te plagen...')
	
	if times_switched > 10 and is_enabled == false:
		$TextureButton.disabled = true
		$SpeechBubble.set_text('Klaar nu, tijd om verder te gaan')


func _on_Button_pressed():
	#end game
	$ScoreMessage/CanvasLayer.show_message(10)
	Global.house2_score += 10
	$Timer.start()


func _on_Timer_timeout():
	$Cat.hide()
	emit_signal("ask_question", "Houses/House2_floor2")
