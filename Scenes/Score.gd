extends Node2D

signal update_score

var score
var score2

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0
	$CanvasLayer/Message.text = "+10"
	$CanvasLayer/Message.hide()
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if Input.is_action_just_pressed("throw_ball"):	#spacebar
		#$CanvasLayer/AnimationPlayer.play("show_message")
		#score += 10
	score = Global.total_score
	$Control.update_bar1(score) #197 max
	score2 = Global.house2_score
	$Control.update_bar2(score2) #67 max
	

func update_score(added_score: int):
	$CanvasLayer/Message.text = "+" + String(added_score)
	if added_score == 0:
		$CanvasLayer/Message.add_color_override("font_color", Color(255,0,0))
	if added_score == 5:
		$CanvasLayer/Message.add_color_override("font_color", Color(255,255,255))
	if added_score == 10:
		$CanvasLayer/Message.add_color_override("font_color", Color(0,255,0))
	$CanvasLayer/AnimationPlayer.play("show_message")
	score += added_score
	print(score, added_score)
	$Control.update_bar(score)
	get_parent().emit_signal("update_score", added_score)
	
