extends Node2D

var firstDelay = true

func _ready():
	if firstDelay:
		firstDelay = false
		$WorldBorder/PlayerArea.count_down()
	var _con = get_viewport().connect("size_changed", self, "_on_resize")
	$BackgroundSprite.scale = Vector2(0.425*GlobalVars.currentResolution[0]/1280, 0.425*GlobalVars.currentResolution[0]/1280)
	$BackgroundSprite.position = GlobalVars.currentResolution / 2


func _input(_event):
	if Input.is_action_just_pressed("ui_fullscreen"):
		call_deferred("toggle_fullscreen")
	elif Input.is_action_just_pressed("ui_cancel"):
		var popup = AcceptDialog.new()
		popup.dialog_text = "Exit to main menu?"
		popup.window_title = ""
		add_child(popup)
		popup.rect_position = GlobalVars.currentResolution / 2 - Vector2(50, 30)
		popup.show()
		popup.connect("confirmed", self, "_on_exit_confirm")


func _on_exit_confirm():
	var _sc = get_tree().change_scene("Menu.tscn")


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
	if OS.window_size[0] < GlobalVars.minimumResolution[0]:
		OS.window_size[0] = GlobalVars.minimumResolution[0]
	if OS.window_size[1] < GlobalVars.minimumResolution[1]:
		OS.window_size[1] = GlobalVars.minimumResolution[1]
	if OS.window_size[0] / OS.window_size[1] < GlobalVars.minimumAspectRatio:
		OS.window_size[0] = OS.window_size[1]
	call_deferred("_on_resize_2")


func _on_resize_2():
	call_deferred("free")
	GlobalVars.currentResolution = OS.window_size
	var _sc = get_tree().reload_current_scene()
