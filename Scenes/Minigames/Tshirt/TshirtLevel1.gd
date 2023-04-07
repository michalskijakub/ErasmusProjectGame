extends Node2D

signal update_score
signal level_changed

var current_clothing
var next_level

var throwout
var keep
var donate


# Called when the node enters the scene tree for the first time.
func _ready():
	$Scissors.hide()
	$Poof.hide()
	$BrokenShorts.hide()
	part0()

func part0():
	$SpeechBubble.set_text("We gaan je oude kleren opruimen! Je kan voor elk kledingstuk \nkiezen wat je wilt doen, " + 
	"weggeven, houden of weggooien. \nLaten we beginnen!")
	$throw_away_button.hide()
	$donation_button.hide()
	$keep_button.hide()
	$Timer.start()


func part1():	# Dirty shirt
	current_clothing = $DirtyShirt
	$SpeechBubble.set_text("Wat wil je doen met dit oude, kapotte shirt?")
	throwout = 10
	keep = 5
	donate = 0
	$AnimationPlayer.set_animation("DirtyShirt")
	next_level = "part2"

func part2():
	current_clothing = $GoodSweater
	$SpeechBubble.set_text("Wat wil je doen met deze trui?")
	throwout = 0
	keep = 5
	donate = 10
	$AnimationPlayer.set_animation("GoodSweater")
	next_level = "part3"

func part3():
	current_clothing = $OldUnderwear
	$SpeechBubble.set_text("Iewll! Een vieze kapotte onderbroek!")
	throwout = 10
	keep = 5
	donate = 0
	$AnimationPlayer.set_animation("OldUnderwear")
	next_level = "part4"

func part4():
	current_clothing = $RippedSweater
	$SpeechBubble.set_text("Wat doen we met deze oude trui?")
	throwout = 10
	keep = 5
	donate = 0
	$AnimationPlayer.set_animation("RippedSweater")
	next_level = "part5"

func part5():
	current_clothing = $SmallSweater
	$SpeechBubble.set_text("Deze trui is te klein geworden, wat wil je ermee doen?")
	throwout = 0
	keep = 5
	donate = 10
	$AnimationPlayer.set_animation("SmallSweater")
	next_level = "part6"

func part6():
	current_clothing = $RippedShirt
	$SpeechBubble.set_text("Wat wil je doen met dit kapotte shirt?")
	throwout = 10
	keep = 5
	donate = 0
	$AnimationPlayer.set_animation("RippedShirt")
	next_level = "part7"

func part7():
	current_clothing = $BrokenShorts
	$BrokenShorts.show()
	$SpeechBubble.set_text("Deze broek is alleen aan de onderkant kapot, \n misschien kunnen we er een korte broek van maken!")
	$AnimationPlayer.set_animation("BrokenShorts")
	
	throwout = 0
	keep = 5
	donate = 10
	
	# hide buttons
	$throw_away_button.hide()
	$donation_button.hide()
	$keep_button.hide()
	
	$Scissors.show()

func end():
	emit_signal("level_changed", "Minigames/Tshirt/Tshirt")

func _on_keep_button_pressed():
	$AnimationPlayer.play("keep")
	yield(get_node("AnimationPlayer"), "animation_finished")
	Global.total_score += keep
	$ScoreMessage/CanvasLayer.show_message(keep)
	call(next_level)

func _on_donation_button_pressed():
	$AnimationPlayer.play("donate")
	yield(get_node("AnimationPlayer"), "animation_finished")
	Global.total_score += donate
	$ScoreMessage/CanvasLayer.show_message(donate)
	if donate == 10:
		$Correctsound.play()
	else:
		$Wrongsound.play()
	
	call(next_level)


func _on_throw_away_button_pressed():
	$AnimationPlayer.play("throwout")
	yield(get_node("AnimationPlayer"), "animation_finished")
	Global.total_score += throwout
	$ScoreMessage/CanvasLayer.show_message(throwout)
	if throwout == 10:
		$Correctsound.play()
	else:
		$Wrongsound.play()
		
	call(next_level)


func _on_ScissorsButton_pressed():
	$AnimationPlayer.play("cut_pants")
	yield(get_node("AnimationPlayer"), "animation_finished") # wait for animation to finish
	$Scissors.hide()
	$AnimationPlayer.set_animation("GoodShorts")
	$SpeechBubble.set_text("Goed gedaan! Wat wil je nu met deze broek doen?")
	next_level = "end"
	
	$throw_away_button.show()
	$donation_button.show()
	$keep_button.show()


func _on_Timer_timeout():
	$throw_away_button.show()
	$donation_button.show()
	$keep_button.show()
	part1()
