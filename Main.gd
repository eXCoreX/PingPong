extends Node2D

func _ready():
	pass


func _input(_event):
	if Input.is_action_just_pressed("ui_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
