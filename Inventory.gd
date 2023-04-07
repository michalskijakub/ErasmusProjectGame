extends Node2D


var inventory = []
var game_finished = false
signal rubbish_friend_start
signal rubbish_friend_finish
signal ask_question
signal update_score


# Called when the node enters the scene tree for the first time.
func _ready():
	inventory = Global.player_inventory
	$Sock.hide()
	$Pen.hide()
	$Shoelace.hide()
	$Paper.hide()
	$Button.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	inventory = Global.player_inventory
	if "sock" in inventory:
		$Sock.show()
	if "pen" in inventory:
		$Pen.show()
	if "shoelace" in inventory:
		$Shoelace.show()
	if "paper" in inventory:
		$Paper.show()
	
	if "sock" in inventory and "pen" in inventory and "shoelace" in inventory and "paper" in inventory and not game_finished:
		game_finished = true
		make_rubbish_friend()

func make_rubbish_friend():
	Global.can_walk = false
	Global.can_interact = false
	emit_signal("rubbish_friend_start")
	$AnimationPlayer.play("cat_enter")
	yield(get_node("AnimationPlayer"), "animation_finished")
	$SpeechBubble.set_text("Met de spullen die je verzameld \nhebt kan je een leuke pop maken!")
	$Button.show()
	Global.player_inventory.clear()
	Global.player_inventory.append("rubbish_friend")


func _on_Button_pressed():
	$Button.hide()
	$SpeechBubble.hide()
	$AnimationPlayer.play("cat_exit")
	yield(get_node("AnimationPlayer"), "animation_finished")
	$AnimationPlayer.play("create_rubbish_friend")
	yield(get_node("AnimationPlayer"), "animation_finished")
	Global.total_score += 5
	$ScoreMessage/CanvasLayer.show_message(5)
	emit_signal("rubbish_friend_finish")
	emit_signal("ask_question")
	
