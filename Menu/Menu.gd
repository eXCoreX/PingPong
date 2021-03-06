extends Control

func _ready():
	var _con = get_viewport().connect("size_changed", self, "_on_resize")
	pass


func _input(_event):
	if Input.is_action_just_pressed("ui_fullscreen"):
		call_deferred("toggle_fullscreen")

func toggle_fullscreen():
	if !OS.window_fullscreen:
		GlobalVars.lastResolution = OS.window_size
		GlobalVars.currentResolution = OS.get_screen_size()
	else:
		GlobalVars.currentResolution = GlobalVars.lastResolution
	get_viewport().size = GlobalVars.currentResolution
	OS.window_fullscreen = !OS.window_fullscreen
	OS.window_size = GlobalVars.currentResolution
	print(OS.window_size)
	call_deferred("_on_resize")


func _on_resize():
	if OS.window_size[0] < 1000:
		OS.window_size[0] = 1000
	if OS.window_size[1] < GlobalVars.minimumResolution[1]:
		OS.window_size[1] = GlobalVars.minimumResolution[1]
	if OS.window_size[0] / OS.window_size[1] < GlobalVars.minimumAspectRatio:
		OS.window_size[0] = OS.window_size[1]
	call_deferred("_on_resize_2")


func _on_resize_2():
	call_deferred("free")
	GlobalVars.currentResolution = OS.window_size
	var _sc = get_tree().reload_current_scene()
