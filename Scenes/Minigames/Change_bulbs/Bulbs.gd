extends Node2D

signal ask_question

var sco = 0
var timer_started = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$LedOn1.hide()
	$LedOn2.hide()
#	$LedOn3.hide()
	$LedOn4.hide()
	$Lightimage.hide()
	$Lightimage2.hide()
#	$Lightimage3.hide()
	$Lightimage4.hide()
	$New_bulb.hide()
	$New_bulb2.hide()
	#$New_bulb3.hide()
	$New_bulb4.hide()
	$Old_bulb.connect("correct_score", self, "handle_correct_score")
	$Old_bulb2.connect("correct_score1", self, "handle_correct_score1")
#	$Old_bulb3.connect("correct_score4", self, "handle_correct_score4")
	$Old_bulb4.connect("correct_score5", self, "handle_correct_score5")
	$New_bulb.connect("correct_score2", self, "handle_correct_score2")
	$New_bulb2.connect("correct_score3", self, "handle_correct_score3")
	#New_bulb3.connect("correct_score6", self, "handle_correct_score6")
	$New_bulb4.connect("correct_score7", self, "handle_correct_score7")
	$HUD/Score.text = "Vervang de oude gloeilampen met LED lampen."

func _process(delta):
	if sco == 6 and timer_started == false:
		timer_started = true
		$Timer.start()
	#print(sco)


func _on_Timer_timeout():
	print("changing scene")
	emit_signal("ask_question", "Houses/House2_floor1")


func handle_correct_score(score):
	sco +=1
	$New_bulb.show()
	#$HUD.update_score(sco)


func handle_correct_score1(score):
	sco +=1
	$New_bulb2.show()
	#$HUD.update_score(sco)
	
	
func handle_correct_score4(score):
	sco +=1
	$New_bulb3.show()
	#$HUD.update_score(sco)
	

func handle_correct_score5(score):
	sco +=1
	$New_bulb4.show()
	#$HUD.update_score(sco)
	

func handle_correct_score2(score):
	sco +=1
	$LedOn1.show()
	$Lightimage.show()
	#$HUD.update_score(sco)
	$AudioStreamPlayer.play()
	$ScoreMessage/CanvasLayer.show_message(5)
	Global.house2_score += 5

func handle_correct_score3(score):
	sco +=1
	$LedOn2.show()
	$Lightimage2.show()
	#$HUD.update_score(sco)
	$AudioStreamPlayer.play()
	$ScoreMessage/CanvasLayer.show_message(5)
	Global.house2_score += 5


func handle_correct_score6(score):
	sco +=1
	$LedOn3.show()
	$Lightimage3.show()
	#$HUD.update_score(sco)


func handle_correct_score7(score):
	sco +=1
	$LedOn4.show()
	$Lightimage4.show()
	#$HUD.update_score(sco)
	$AudioStreamPlayer.play()
	$ScoreMessage/CanvasLayer.show_message(5)
	Global.house2_score += 5



