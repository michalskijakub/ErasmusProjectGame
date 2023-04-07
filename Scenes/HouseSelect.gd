extends Node2D

signal level_changed(next_level_name)


# Called when the node enters the scene tree for the first time.
func _ready():
	$House1Highlight.hide()
	$House2Highlight.hide()
	$House3Highlight.hide()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Score/TextureProgress.value = Global.total_score + Global.house2_score
	if $House1Button.is_hovered():
		$House1Highlight.show()
	else:
		$House1Highlight.hide()
	
	if $House2Button.is_hovered():
		$House2Highlight.show()
	else:
		$House2Highlight.hide()
	
	if $House3Button.is_hovered():
		$House3Highlight.show()
	else:
		$House3Highlight.hide()


func _on_House1Button_pressed():
	Globalscene.doorslam()
	Global.current_house = 1
	emit_signal("level_changed", "Houses/House1_floor1")

func _on_House2Button_pressed():
	if Global.total_score >= 135: 	#135
		Globalscene.doorslam()
		Global.current_house = 2
		emit_signal("level_changed", "Houses/House2_floor1")
	else:
		Globalscene.door_locked()
		$SpeechBubble.set_text("Verdien meer punten in het eerste huis  \nom dit huis vrij te spelen.", 4)

func _on_House3Button_pressed():
	Globalscene.door_locked()
	$SpeechBubble.set_text("In deze versie van het spel is dit huis\n nog niet beschikbaar, sorry!", 4)


func _on_Timer_timeout():
	$SpeechBubble.set_text("")
	$AnimationPlayer.play("exit")
