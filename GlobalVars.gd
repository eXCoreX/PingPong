extends Node

var scorePlayer = 0
var scoreEnemy  = 0
var currentResolution = Vector2(1280, 720)
var lastResolution = currentResolution
var currentDifficulty = 1

func _ready():
	currentResolution = OS.window_size


func _unpause():
	get_tree().paused = false
