extends Label

func _ready():
	self.rect_size = get_parent().rect_size
	print(rect_size)
