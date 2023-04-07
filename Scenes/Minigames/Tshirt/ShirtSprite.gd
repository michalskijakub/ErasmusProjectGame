extends Sprite


onready var current_line2D = Line2D.new()
var curve2d : Curve2D
var last_position : Vector2
export var speed = 5
var started = false #stops the pathfollow setting off without a path
var all_lines : Array
var current_color = Color( 0.4, 0.5, 1, 1)



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event: InputEvent) -> void:
	pass
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		started = true
		curve2d = null

		#start from the last position except for the first line
		#if current_line2D.points.size() == 0 && last_position:
		#	current_line2D.add_point(last_position)

		#draw the points
		if event is InputEventMouseMotion:
			current_line2D.add_point(event.position)
	
	if Input.is_action_just_released("MOUSE_LEFT"):
		all_lines.append(current_line2D)
		
		current_line2D = Line2D.new()
		current_line2D.set_default_color(current_color)
		add_child(current_line2D)
		
		print(current_line2D.get_parent())
	
	if Input.is_key_pressed(KEY_SPACE):
		for line in all_lines:
			line.queue_free()
		all_lines = []


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
