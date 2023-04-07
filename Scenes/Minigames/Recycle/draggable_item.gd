extends Area2D


var can_grab
var grabbed_offset = Vector2()
var is_grabbed = false
var in_correct_bin = false
var in_wrong_bin = false
var in_bins = 0 #amount of bins hovered by item (don't do anything if not equal to 1)


onready var main = get_parent().get_parent() #top node in the scene tree

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	if in_correct_bin and !is_grabbed and in_bins == 1:
		queue_free()
		main.get_node("CorrectSound").play()
		main.get_node("ScoreMessage/CanvasLayer").show_message(5)
		Global.total_score += 5
		main.items_recycled += 1
	if !in_correct_bin and !is_grabbed and in_bins == 1:
		queue_free()
		main.get_node("WrongSound").play()
		main.get_node("ScoreMessage/CanvasLayer").show_message(0)
		main.items_recycled += 1
	
	if is_grabbed:
		position = get_global_mouse_position()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		is_grabbed = event.pressed
