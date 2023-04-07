extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sco = 0
var temp6 = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$Organic_object.connect("correct_score", self, "handle_correct_score")
	$Glass_object.connect("correct_score2", self, "handle_correct_score2")
	$Plastic_object.connect("correct_score3", self, "handle_correct_score3")
	$Metal_object.connect("correct_score4", self, "handle_correct_score4")
	$Battery_object.connect("correct_score5", self, "handle_correct_score5")
	$Paper_object.connect("correct_score6", self, "handle_correct_score6")
	$Plastic_object.connect("correct_score7", self, "handle_correct_score7")
	$Glass_object.connect("correct_score8", self, "handle_correct_score8")
func handle_correct_score(score):
	sco +=1
	$HUD.update_score(sco)

func handle_correct_score2(score):
	sco +=1
	$HUD.update_score(sco)

func handle_correct_score3(score):
	sco +=1
	$HUD.update_score(sco)

func handle_correct_score4(score):
	sco +=1
	$HUD.update_score(sco)

func handle_correct_score5(score):
	sco +=1
	$HUD.update_score(sco)

func handle_correct_score6(score):
	sco +=1
	$HUD.update_score(sco)

func handle_correct_score7(score):
	sco +=2
	$HUD.update_score(sco)

func handle_correct_score8(score):
	sco +=2
	$HUD.update_score(sco)

