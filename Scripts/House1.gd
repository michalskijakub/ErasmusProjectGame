extends Node2D

signal level_changed(next_level_name)

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = load("res://Scenes/Player.tscn").instance()
	player.position = (Vector2(919, 870))
	add_child(player)
	
	
	

func _on_Area2D_body_entered(body):
	#print("entered")
	emit_signal("level_changed", "HouseSelect")


func _process(delta):
	if Input.is_action_pressed("start_minigame"):
		emit_signal("level_changed", "Minigames/Tshirt/TshirtLevel1")
		
