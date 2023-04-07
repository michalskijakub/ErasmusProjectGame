extends AnimationPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_animation(objectname: String):
	# Set entry animation
	var animation = Animation.new()
	var track_index = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(track_index, objectname+":position:x")
	animation.track_insert_key(track_index, 0.0, -500)
	animation.track_insert_key(track_index, 1.0, 1000)
	add_animation(objectname, animation)
	if objectname != "GoodShorts":
		play(objectname)
	
	# Set 'donate' animation
	var donateanimation = Animation.new()
	track_index = donateanimation.add_track(Animation.TYPE_VALUE)
	donateanimation.track_set_path(track_index, objectname+":position:x")
	donateanimation.track_insert_key(track_index, 0.0, 1000)
	donateanimation.track_insert_key(track_index, 1.0, 3000)
	add_animation("donate", donateanimation)
	
	# Set 'keep' animation
	var keepanimation = Animation.new()
	track_index = keepanimation.add_track(Animation.TYPE_VALUE)
	keepanimation.track_set_path(track_index, objectname+":position:y")
	keepanimation.track_insert_key(track_index, 0.0, 550)
	keepanimation.track_insert_key(track_index, 1.0, 2000)
	add_animation("keep", keepanimation)
	
	# Set 'throwout' animation
	var throwoutanimation = Animation.new()
	track_index = throwoutanimation.add_track(Animation.TYPE_VALUE)
	throwoutanimation.track_set_path(track_index, objectname+":position:x")
	throwoutanimation.track_insert_key(track_index, 0.0, 1000)
	throwoutanimation.track_insert_key(track_index, 1.0, -500)
	add_animation("throwout", throwoutanimation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
