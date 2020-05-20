extends Area2D

const BALLSC = preload("res://Ball.tscn")

var timer = Timer.new()

func _ready():
	timer.connect("timeout", self, "count_down")
	add_child(timer, true)

onready var glVars = $"../../../GlobalVars"

func _on_ScoreArea_body_entered(_body):
	$"../PlayerArea".disconnect("body_entered", $"../PlayerArea", "_on_ScoreArea_body_entered")
	$"../EnemyArea".disconnect("body_entered", $"../EnemyArea", "_on_ScoreArea_body_entered")
	if self.name == "EnemyArea":
		glVars.scorePlayer += 1
	else:
		glVars.scoreEnemy  += 1
	timer.start(3)
	$"../../Label".text = "SCORE:\nYOU%8d\nENEMY%3d" % [glVars.scorePlayer, glVars.scoreEnemy]
	$"../../Label".show()


var time = 3

func count_down():
	if time == 3:
		timer.stop()
		$"../../Label".hide()
		$"../../TimeLabel".text = "3"
		$"../../TimeLabel".show()
		time -= 1
		timer.start(1)
	elif time == 0:
		timer.stop()
		$"../../TimeLabel".hide()
		time = 3
		call_deferred("reload_scene")
	else:
		$"../../TimeLabel".text = String(time)
		time -= 1


func reload_scene():
	$"../../Ball".free()
	var to_add = BALLSC.instance()
	to_add.name = "Ball"
	$"../../".add_child(to_add)
	var _c = $"../PlayerArea".connect("body_entered", $"../PlayerArea", "_on_ScoreArea_body_entered")
	var _c2 = $"../EnemyArea".connect("body_entered", $"../EnemyArea", "_on_ScoreArea_body_entered")
	
