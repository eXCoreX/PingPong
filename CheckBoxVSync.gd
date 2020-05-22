extends CheckBox

func _ready():
	self.pressed = GlobalVars.vSyncEnabled


func _on_CheckBox_toggled(button_pressed):
	GlobalVars.vSyncEnabled = button_pressed
