extends Node2D

signal level_changed(next_level_name)

var player
var can_pickup_sock = false
var can_pickup_pen = false
var interact_recycle = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D/RecycleGame/RecycleHighlight.hide()
	
	if "sock" in Global.player_inventory or "rubbish_friend" in Global.player_inventory:
		$Sock.hide()
	if "pen" in Global.player_inventory or "rubbish_friend" in Global.player_inventory:
		$Pen.hide()


func _on_Stairs_body_entered(body):
	emit_signal("level_changed", "Houses/House1_floor2")


func _process(delta):
	if Input.is_action_pressed("ui_accept") and can_pickup_sock == true:
		$AnimationPlayer.play("pickup_sock")
		yield(get_node("AnimationPlayer"), "animation_finished")
		Global.player_inventory.append("sock")
	if Input.is_action_pressed("ui_accept") and can_pickup_pen == true:
		$AnimationPlayer.play("pickup_pen")
		yield(get_node("AnimationPlayer"), "animation_finished")
		Global.player_inventory.append("pen")
	
	if Input.is_action_pressed("ui_accept") and interact_recycle == true:
			Global.player_position = $Player.position
			start_recycle_game()


func _on_Frontdoor_body_entered(body):
	Globalscene.doorslam()
	emit_signal("level_changed", "HouseSelect")


func _on_Sock_body_entered(body):
	if body == $Player:
		if "sock" in Global.player_inventory or "rubbish_friend" in Global.player_inventory:
			can_pickup_sock = false
		else:
			can_pickup_sock = true
	


func _on_Sock_body_exited(body):
	if body == $Player:
		print("exited sock")
		can_pickup_sock = false
	


func _on_Pen_body_entered(body):
	if body == $Player:
		if  "pen" in Global.player_inventory or "rubbish_friend" in Global.player_inventory:
			can_pickup_pen = false
		else:
			can_pickup_pen = true
		


func _on_Pen_body_exited(body):
	if body == $Player:
		can_pickup_pen = false
	


func _on_Area2D2_body_entered(body):
	pass # Replace with function body.


func _on_Toilet_body_entered(body):
	$Toilet/ToiletFlush.play()


func _on_RecycleGame_body_entered(body):
	if body == $Player:
		$Area2D/RecycleGame/RecycleHighlight.show()
		interact_recycle = true


func _on_RecycleGame_body_exited(body):
	if body == $Player:
		$Area2D/RecycleGame/RecycleHighlight.hide()
		interact_recycle = false

func start_recycle_game():
	Global.can_walk = false
	$AnimationPlayer.play("Cat_entry")
	yield(get_node("AnimationPlayer"), "animation_finished")
	$SpeechBubble.set_text("We kunnen het beste naar de supermarkt  \ngaan om dit afval te scheiden!")
	$SpeechBubble/Timer2.start()

func _on_Timer2_timeout():
	$SpeechBubble.hide()
	$AnimationPlayer.play("Cat_exit")
	yield(get_node("AnimationPlayer"), "animation_finished")
	Global.can_walk = true
	emit_signal("level_changed", "Minigames/Recycle/Recycle")
