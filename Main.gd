extends Node2D

var firstDelay = true

func _ready():
	if firstDelay:
		firstDelay = false
		$WorldBorder/PlayerArea.count_down()
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
	call_deferred("_on_resize_2")
	pass


func _on_resize_2():
	call_deferred("free")
	GlobalVars.currentResolution = OS.window_size
	var _sc = get_tree().reload_current_scene()
