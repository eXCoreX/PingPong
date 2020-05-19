extends Area2D

var timer = Timer.new()

func _ready():
	timer.connect("timeout", self, "reload_scene")
	add_child(timer)

onready var glVars = $"../../../GlobalVars"

func _on_ScoreArea_body_entered(_body):
	if self.name == "EnemyArea":
		glVars.scorePlayer += 1
	else:
		glVars.scoreEnemy  += 1
	timer.start(3)
	$"../../Label".text = "SCORE:\nYOU \t" + String(glVars.scorePlayer) + "\nENEMY \t" + String(glVars.scoreEnemy)
	$"../../Ball".hide()
	$"../../Ball".sleeping = true
	call_deferred("disableColl")
	$"../../Label".show()


func disableColl():
	$"../../Ball/CollisionShape2D".disabled = true


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
		get_tree().reload_current_scene()
	else:
		$"../../TimeLabel".text = String(time)
		time -= 1

	
