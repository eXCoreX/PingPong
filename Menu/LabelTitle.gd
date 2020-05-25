extends Label


func _ready():
	pass


var i = 0.0

func _process(delta):
	var color = Color.from_hsv(i, 1, 1)
	i += delta * 0.33
	if i > 1:
		i = 0
	self.add_color_override("font_color", color)
