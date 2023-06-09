tool
extends Polygon2D

export(Color) var OutLine = Color(255,255,0) setget set_color
export(float) var Width = 2.0 setget set_width

func _ready():
	set_color(Color(255,255,0))
	set_width(3.0)

func _draw():
	var poly = get_polygon()
	for i in range(1 , poly.size()):
		draw_line(poly[i-1] , poly[i], OutLine , Width)
	draw_line(poly[poly.size() - 1] , poly[0], OutLine , Width)

func set_color(color):
	OutLine = color
	update()

func set_width(new_width):
	Width = new_width
	update()
