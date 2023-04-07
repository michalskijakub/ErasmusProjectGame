extends Node

var score = 0
var house1_scenes = ["Houses/House1_floor1", "Houses/House1_floor2"]
var house2_scenes = ["Houses/House2_floor1", "Houses/House2_floor2"] # scenes where to show the progressbar
var game_ended = false

# main
func _ready():
	$EndGame.hide()
	$Inventory.connect("rubbish_friend_start", self, "handle_rubbish_friend_start")
	$Inventory.connect("rubbish_friend_finish", self, "handle_rubbish_friend_finish")
	$Inventory.connect("ask_question", $SceneSwitcher, "handle_ask_question")
	randomize()


func _process(delta):
	if $SceneSwitcher.is_asking_question:
		$Score/Control/House1Progress.hide()
		$Score/Control/House2Progress.hide()
		$Inventory.hide()
	elif $SceneSwitcher.current_level_name in house1_scenes:
		$Score/Control/House1Progress.show()
		$Inventory.show()
		
	elif $SceneSwitcher.current_level_name in house2_scenes:
		$Score/Control/House2Progress.show()
		$Inventory.show()
	else:
		$Score/Control/House1Progress.hide()
		$Score/Control/House2Progress.hide()
		$Inventory.hide()
	
	if Global.total_score == 200 and Global.house2_score == 80 and !game_ended:
		if $SceneSwitcher.current_level_name in house1_scenes or $SceneSwitcher.current_level_name in house2_scenes:
			game_ended = true
			end_game()

func end_game():
	Global.can_walk = false
	Global.can_interact = false
	$EndGame/SpeechBubble.set_text("Gefeliciteerd, je hebt het maximale\n aantal punten gehaald!\n Je kan nog gewoon doorspelen!")
	$EndGame.show()
	$EndGame/AnimationPlayer.play("entry")

func handle_update_score(add_score):
	score += add_score
	$Score.update_score1(add_score)

func handle_rubbish_friend_start():
	$SceneSwitcher.modulate = "#404040"

func handle_rubbish_friend_finish():
	$SceneSwitcher.modulate = "#ffffff"	


func _on_Button_pressed():
	Global.can_walk = true
	Global.can_interact = true
	$EndGame.hide()
