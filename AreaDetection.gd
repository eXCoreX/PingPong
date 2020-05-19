extends Area2D

var timer = Timer.new()

func _ready():
	timer.connect("timeout", self, "reload_scene")
	add_child(timer)

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

func reload_scene():
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
		var _s = get_tree().reload_current_scene()
	else:
		$"../../TimeLabel".text = String(time)
		time -= 1
