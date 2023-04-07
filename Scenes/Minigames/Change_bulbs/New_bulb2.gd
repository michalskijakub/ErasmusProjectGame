extends Node2D

var can_grab = false
var grabbed_offset = Vector2()

var enlarged = false
var score = 0
signal correct_score3

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		can_grab = event.pressed
		grabbed_offset = position - get_global_mouse_position()

func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_grab:
		# Increases size when dragging
		if not enlarged:
			self.scale = Vector2(self.scale.x * 1.2, self.scale.y * 1.2)
			enlarged = true
		# Changes position to mouse position
		position = get_global_mouse_position() + grabbed_offset

	if not Input.is_mouse_button_pressed(BUTTON_LEFT):
		# Decreases size when no longer dragging
		if enlarged:
			self.scale = Vector2(self.scale.x / 1.2, self.scale.y / 1.2)
			enlarged = false

func _on_Area2D2_bulb2_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area == $Area2D:
		area.queue_free()
		emit_signal('correct_score3', score)
	pass # Replace with function body.
