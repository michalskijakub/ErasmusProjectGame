extends Node2D

signal fly_in_finished
signal level_changed
signal update_score

var question # =  "Why are bananas yellow?"
var answer_right # = "It's their favourite colour"
var answer_wrong1 # = "They look like the sun"
var answer_wrong2 # = "It gives them flavour"
var explanation # = "Omdat blablablbla"

var correct_answer
var already_answered = false
var next_level
var correct_button
var questions_answered = 0
const MAX_QUESTIONS = 3
var questions_asked = []
var randomint
var all_correct


# Called when the node enters the scene tree for the first time.
func _ready():
	questions_asked = []
	randomize()
	read_json()
	$Button1.hide()
	$Button2.hide()
	$Button3.hide()
	$NextButton.hide()
	fly_in()
	

func fly_in():		# note: this should be done with an animationplayer instead
	var pos = $AnimatedSprite.get_position()
	var x = pos[0]
	for i in range(85):
		$AnimatedSprite.position.x = x+8
		x = x + 8
		yield(get_tree(), "idle_frame") #waits execution of the loop one frame
	emit_signal("fly_in_finished")

func _on_main_fly_in_finished():
	$SpeechBubble.set_text(question)
	show_answers()
	#$Tween.interpolate_property($Button)
	

func show_answers():
	$Button1.show()
	$Button2.show()
	$Button3.show()
	
	# randomize answers
	var randomint = randi() % 3
	if randomint == 0:
		correct_answer = 1
		$Button1.text = answer_right
		$Button2.text = answer_wrong1
		$Button3.text = answer_wrong2
		
		correct_button = $Button1
	if randomint == 1:
		correct_answer = 2
		$Button2.text = answer_right
		$Button1.text = answer_wrong1
		$Button3.text = answer_wrong2
		
		correct_button = $Button2
	if randomint == 2:
		correct_answer = 3
		$Button3.text = answer_right
		$Button2.text = answer_wrong1
		$Button1.text = answer_wrong2
		
		correct_button = $Button3


func _on_Button_pressed():
	if already_answered:
		return
	
	if correct_answer == 1 or all_correct == 1:
		add_score(5)
		$ScoreMessage/CanvasLayer.show_message(5)
		$CorrectSound.play()
		flash_button($Button1, 1)
	else:
		$WrongSound.play()
		flash_button($Button1, 0)
	
	already_answered = true

func _on_Button2_pressed():
	if already_answered:
		return
	
	if correct_answer == 2 or all_correct == 1:
		add_score(5)
		$ScoreMessage/CanvasLayer.show_message(5)
		$CorrectSound.play()
		flash_button($Button2, 1)
	else:
		$WrongSound.play()
		flash_button($Button2, 0)
	
	already_answered = true

func _on_Button3_pressed():
	if already_answered:
		return
	
	if correct_answer == 3 or all_correct == 1:
		add_score(5)
		$ScoreMessage/CanvasLayer.show_message(5)
		$CorrectSound.play()
		flash_button($Button3, 1)
	else:
		$WrongSound.play()
		flash_button($Button3, 0)
	
	already_answered = true


func flash_button(button, correct):			#0 incorrect, 1 correct
	var correct_style = StyleBoxFlat.new()
	var wrong_style = StyleBoxFlat.new()
	correct_style.set_bg_color(Color('#197711'))
	wrong_style.set_bg_color(Color('#c31f1f'))
	#$Button.set("custom_styles/normal", correct_style)
	
	if correct:
		button.set("custom_styles/normal", correct_style)
		button.set("custom_styles/hover", correct_style)
	else:
		button.set("custom_styles/normal", wrong_style)
		button.set("custom_styles/hover", wrong_style)
		
		correct_button.set("custom_styles/normal", correct_style)
		correct_button.set("custom_styles/hover", correct_style)
	
	$RichTextLabel.text = explanation
	$RichTextLabel.show()
	
	end_question()


func read_json():
	var file = File.new()
	if Global.current_house == 2:
		file.open("res://Assets/questions2.json", file.READ)
	else:
		file.open("res://Assets/questions1.json", file.READ)
	var json = file.get_as_text()
	var json_result = JSON.parse(json).result
	file.close()
	
	var rand = randi()
	randomint = rand % json_result.size()
	
	while randomint in questions_asked:
		rand = randi()
		randomint = rand % json_result.size()
	questions_asked.append(randomint)
	var questionanswer = json_result[randomint]
	#var questionanswer = json_result[2]		#2 alles goed
	print(questions_asked)
	
	question = questionanswer["question"]
	answer_right = questionanswer["correct_answer"]
	answer_wrong1 = questionanswer["wrong_answer1"]
	answer_wrong2 = questionanswer["wrong_answer2"]
	explanation = questionanswer["explanation"]
	
	# Check for questions2, question 2
	if Global.current_house == 2 and randomint == 2:
		all_correct = 1
	else:
		all_correct = 0
	

func end_question():
	questions_answered += 1
	if questions_answered < MAX_QUESTIONS:
		$NextButton.set_text("Volgende vraag!")
		$NextButton.show()
	else:
		$NextButton.set_text("Verder met het spel!")
		$NextButton.show()


func reset_scene():
	$Button1.set("custom_styles/normal", null)
	$Button1.set("custom_styles/hover", null)
	$Button2.set("custom_styles/normal", null)
	$Button2.set("custom_styles/hover", null)
	$Button3.set("custom_styles/normal", null)
	$Button3.set("custom_styles/hover", null)
	$SpeechBubble.hide()
	$RichTextLabel.hide()
	$NextButton.hide()

func add_score(score: int):
	if Global.current_house == 1:
		Global.total_score += score
	if Global.current_house == 2:
		Global.house2_score += score
	else:
		Global.total_score += score
	


func _on_NextButton_pressed():
	if questions_answered < MAX_QUESTIONS:
		# new question
		reset_scene()
		read_json()
		$SpeechBubble.set_text(question)
		show_answers()
		already_answered = false
	else:
		Global.can_walk = true
		Global.can_interact = true
		queue_free()
		emit_signal("level_changed", next_level)
