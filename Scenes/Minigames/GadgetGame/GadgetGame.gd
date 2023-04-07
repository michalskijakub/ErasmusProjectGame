extends Node2D

signal ask_question

var has_chosen = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Cat/SpeechBubble.set_text("Welke tandenborstel is het goedkoopst \nals je hem minstens 3 jaar gebruikt?")


func _on_ExpensiveButton_pressed():
	if !has_chosen:
		$ScoreMessage/CanvasLayer.show_message(10)
		$Cat/SpeechBubble.set_text("Goed gedaan! Deze is na 3 jaar\n het goedkoopst!")
		Global.house2_score += 10
		has_chosen = true
		$EndGameTimer.start()
		$Correct.play()


func _on_MediumButton_pressed():
	if !has_chosen:
		$ScoreMessage/CanvasLayer.show_message(5)
		$Cat/SpeechBubble.set_text("Deze is naar 3 jaar niet het duurst\n maar ook niet het goedkoopst.")
		Global.house2_score += 5
		has_chosen = true
		$EndGameTimer.start()


func _on_CheapButton_pressed():
	if !has_chosen:
		$ScoreMessage/CanvasLayer.show_message(0)
		$Cat/SpeechBubble.set_text("Helaas... deze is na 3 jaar juist het duurst, \ndoor de prijs van de batterijen.")
		Global.house2_score += 0
		has_chosen = true
		$EndGameTimer.start()
		$Wrong.play()


func _on_EndGameTimer_timeout():
	$Cat.hide()
	emit_signal("ask_question", "Houses/House2_floor2")
