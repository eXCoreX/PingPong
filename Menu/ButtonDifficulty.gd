extends Button

func _ready():
	match self.name:
		"ButtonEasy":
			if GlobalVars.currentDifficulty == 0:
				self.add_color_override("font_color", Color(0.1, 0.7, 0))
			else:
				self.add_color_override("font_color", Color.white)
		"ButtonMedium":
			if GlobalVars.currentDifficulty == 1:
				self.add_color_override("font_color", Color(1, 1, 0))
			else:
				self.add_color_override("font_color", Color.white)
		"ButtonHard":
			if GlobalVars.currentDifficulty == 2:
				self.add_color_override("font_color", Color(1, 0.5, 0))
			else:
				self.add_color_override("font_color", Color.white)
		"ButtonInsane":
			if GlobalVars.currentDifficulty == 3:
				self.add_color_override("font_color", Color(1.0, 0.2, 0))
			else:
				self.add_color_override("font_color", Color.white)


func _on_ButtonDifficulty_pressed():
	var prevdiff = GlobalVars.currentDifficulty
	match self.name:
		"ButtonEasy":
			GlobalVars.currentDifficulty = 0
		"ButtonMedium":
			GlobalVars.currentDifficulty = 1
		"ButtonHard":
			GlobalVars.currentDifficulty = 2
		"ButtonInsane":
			GlobalVars.currentDifficulty = 3
	match prevdiff:
		0:
			$"../ButtonEasy"._ready()
		1:
			$"../ButtonMedium"._ready()
		2:
			$"../ButtonHard"._ready()
		3:
			$"../ButtonInsane"._ready()
	self._ready()
