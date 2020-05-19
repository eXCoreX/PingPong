extends Node

var scorePlayer = 0
var scoreEnemy  = 0
var currentResolution = Vector2(1280, 720)
var lastResolution = currentResolution

func _ready():
	currentResolution = OS.window_size


func _unpause():
	get_tree().paused = false
