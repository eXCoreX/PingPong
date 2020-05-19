extends Node2D

func _ready():
	var _con = get_viewport().connect("size_changed", self, "_on_resize")


func _input(_event):
	if Input.is_action_just_pressed("ui_fullscreen"):
		if !OS.window_fullscreen:
			GlobalVars.lastResolution = OS.window_size
			GlobalVars.currentResolution = OS.get_screen_size()
		else:
			GlobalVars.currentResolution = GlobalVars.lastResolution
		OS.window_fullscreen = !OS.window_fullscreen
		OS.window_size = GlobalVars.currentResolution
		print(OS.window_size)
		get_viewport().size = GlobalVars.currentResolution
		_on_resize()


func _on_resize():
	GlobalVars.currentResolution = OS.window_size
	var _sc = get_tree().reload_current_scene()
