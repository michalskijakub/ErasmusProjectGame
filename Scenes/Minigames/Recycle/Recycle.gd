extends Node2D

signal ask_question

var glassitems = ["Wine"]
var plasticitems = ["Bottle"]
var organicitems = ["Pizza", "Burger"]
var paperitems = ["Paper"]
var restitems = ["GreenCan", "PurpleCan"]
var batteryitems = ["Battery"]

var items_recycled = 0


func _ready():
	$Background.modulate = '#404040'
	$Bins.modulate = '#404040'
	$Items.modulate = '#404040'
	$SpeechBubble.set_text("Gooi het afval in de juiste bak!")


func _process(delta):
	if items_recycled == 8:
		items_recycled += 1
		end_minigame()

func _on_Button_pressed():
	$Background.modulate = '#7b7b7b'
	$Bins.modulate = '#ffffff'
	$Items.modulate = '#ffffff'
	$SpeechBubble.set_text("")
	$SpeechBubble.hide()
	$Button.hide()
	$Cat.hide()


func end_minigame():
	$Cat.show()
	$SpeechBubble.set_text("Goed gedaan, alles is opgeruimd!")
	$Timer.start()


func _on_Timer_timeout():
	$Cat.hide()
	$SpeechBubble.hide()
	emit_signal("ask_question", "Houses/House1_floor1")


func _on_GlassBin_area_entered(area):
	if area.name in glassitems:
		area.in_correct_bin = true
	else:
		area.in_wrong_bin = true
	area.in_bins += 1

func _on_GlassBin_area_exited(area):
	if area.name in glassitems:
		area.in_correct_bin = false
	else:
		area.in_wrong_bin = false
	area.in_bins -= 1

func _on_Plastic_area_entered(area):
	if area.name in plasticitems:
		area.in_correct_bin = true
	else:
		area.in_wrong_bin = true
	area.in_bins += 1


func _on_Plastic_area_exited(area):
	if area.name in plasticitems:
		area.in_correct_bin = false
	else:
		area.in_wrong_bin = false
	area.in_bins -= 1


func _on_Organic_area_entered(area):
	if area.name in organicitems:
		area.in_correct_bin = true
	else:
		area.in_wrong_bin = true
	area.in_bins += 1


func _on_Organic_area_exited(area):
	if area.name in organicitems:
		area.in_correct_bin = false
	else:
		area.in_wrong_bin = false
	area.in_bins -= 1


func _on_Paper_area_entered(area):
	if area.name in paperitems:
		area.in_correct_bin = true
	else:
		area.in_wrong_bin = true
	area.in_bins += 1


func _on_Paper_area_exited(area):
	if area.name in paperitems:
		area.in_correct_bin = false
	else:
		area.in_wrong_bin = false
	area.in_bins -= 1


func _on_Rest_area_entered(area):
	if area.name in restitems:
		area.in_correct_bin = true
	else:
		area.in_wrong_bin = true
	area.in_bins += 1


func _on_Rest_area_exited(area):
	if area.name in restitems:
		area.in_correct_bin = false
	else:
		area.in_wrong_bin = false
	area.in_bins -= 1


func _on_Battery_area_entered(area):
	if area.name in batteryitems:
		area.in_correct_bin = true
	else:
		area.in_wrong_bin = true
	area.in_bins += 1


func _on_Battery_area_exited(area):
	if area.name in batteryitems:
		area.in_correct_bin = false
	else:
		area.in_wrong_bin = false
	area.in_bins -= 1
