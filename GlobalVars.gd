extends Node

var scorePlayer = 0
var scoreEnemy  = 0
var minimumResolution = Vector2(600, 600)
var minimumAspectRatio = 1
var currentResolution = Vector2(1280, 720)
var lastResolution = currentResolution
var currentDifficulty = 1

var vSyncEnabled = true

func _ready():
	currentResolution = OS.window_size


func _unpause():
	get_tree().paused = false
