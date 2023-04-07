extends Node2D

signal level_changed(next_level_name)

var player
var interact_wardrobe = false
var interact_garbage = false
var can_pickup_paper = false
var can_pickup_shoelace = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$House/WardrobeGame/WardrobeHighlight.hide()
	$House/ThrowGarbageGame/GarbageHighlight.hide()
	$Player.position = Global.player_position
	if "shoelace" in Global.player_inventory  or "rubbish_friend" in Global.player_inventory:
		$Shoelace.hide()
	if "paper" in Global.player_inventory  or "rubbish_friend" in Global.player_inventory:
		$Paper.hide()


func _on_Stairs_body_entered(body):
	Global.player_position = Vector2(1229,765) # just outside the stairs hitbox
	emit_signal("level_changed", "Houses/House1_floor1")


func _process(delta):
	if Global.can_interact:
		if Input.is_action_pressed("ui_accept") and interact_wardrobe == true:
			Global.player_position = $Player.position
			emit_signal("level_changed", "Minigames/Tshirt/TshirtLevel1")
		
		if Input.is_action_pressed("ui_accept") and interact_garbage == true:
			Global.player_position = $Player.position
			emit_signal("level_changed", "Minigames/Throwgarbage/throwgarbage")
		
		if Input.is_action_pressed("ui_accept") and can_pickup_paper == true:
			$AnimationPlayer.play("pickup_paper")
			yield(get_node("AnimationPlayer"), "animation_finished")
			Global.player_inventory.append("paper")
		
		if Input.is_action_pressed("ui_accept") and can_pickup_shoelace == true:
			$AnimationPlayer.play("pickup_shoelace")
			yield(get_node("AnimationPlayer"), "animation_finished")
			Global.player_inventory.append("shoelace")


func _on_WardrobeGame_body_entered(body):
	if body == $Player:
		$House/WardrobeGame/WardrobeHighlight.show()
		interact_wardrobe = true

func _on_WardrobeGame_body_exited(body):
	if body == $Player:
		$House/WardrobeGame/WardrobeHighlight.hide()
		interact_wardrobe = false


func _on_ThrowGarbageGame_body_entered(body):
	if body == $Player:
		$House/ThrowGarbageGame/GarbageHighlight.show()
		interact_garbage = true

func _on_ThrowGarbageGame_body_exited(body):
	if body == $Player:
		$House/ThrowGarbageGame/GarbageHighlight.hide()
		interact_garbage = false


func _on_Shoelace_body_entered(body):
	if body == $Player:
		if "shoelace" in Global.player_inventory or "rubbish_friend" in Global.player_inventory:
			can_pickup_shoelace = false
		else:
			can_pickup_shoelace = true


func _on_Shoelace_body_exited(body):
	if body == $Player:
		can_pickup_shoelace = false


func _on_Paper_body_entered(body):
	if body == $Player:
		if "paper" in Global.player_inventory or "rubbish_friend" in Global.player_inventory:
			can_pickup_paper = false
		else:
			can_pickup_paper = true


func _on_Paper_body_exited(body):
	if body == $Player:
		can_pickup_paper = false
