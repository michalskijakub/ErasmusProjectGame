extends Node2D

signal level_changed(next_level_name)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$VideoPlayer.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	$VideoPlayer.show()
	$VideoPlayer.play()
	#$VideoTimer.start()
	


func _on_VideoPlayer_finished():
	emit_signal("level_changed", "Houses/House1_floor1")


func _on_VideoTimer_timeout():
	$VideoPlayer.stop()
	$VideoPlayer.hide()
	emit_signal("level_changed", "Houses/House1_floor1")
