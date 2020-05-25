extends Panel

func _ready():
	self.rect_size = GlobalVars.currentResolution / 2
	self.rect_position = GlobalVars.currentResolution / 4
	for child in get_children():
		child.rect_size = self.rect_size
