extends Node2D

signal level_changed(next_level_name)

var player
var interact_dishwasher = false
var interact_replacelights = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$ReplaceLights/ReplaceHighlight.hide()


func _on_Stairs_body_entered(body):
	if body == $Player:
		Global.player_position = Vector2(656,775) # just outside the stairs hitbox
		emit_signal("level_changed", "Houses/House2_floor2")


func _process(delta):
	if Input.is_action_pressed("ui_accept") and interact_dishwasher == true:
		Global.player_position = $Player.position
		#emit_signal("level_changed", "Minigames/Tshirt/TshirtLevel1")
	
	if Input.is_action_pressed("ui_accept") and interact_replacelights == true:
		Global.player_position = $Player.position
		emit_signal("level_changed", "Minigames/Change_bulbs/Bulbs")


func _on_Frontdoor_body_entered(body):
	Globalscene.doorslam()
	emit_signal("level_changed", "HouseSelect")


func _on_DishWashergame_body_entered(body):
	if body == $Player:
		interact_dishwasher = true


func _on_DishWashergame_body_exited(body):
	if body == $Player:
		interact_dishwasher = false


func _on_ReplaceLights_body_entered(body):
	if body == $Player:
		$ReplaceLights/ReplaceHighlight.show()
		interact_replacelights = true


func _on_ReplaceLights_body_exited(body):
	if body == $Player:
		$ReplaceLights/ReplaceHighlight.hide()
		interact_replacelights = false


func _on_Toilet_body_entered(body):
	if body == $Player:
		$Toilet/ToiletFlush.play()
