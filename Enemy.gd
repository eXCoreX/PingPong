extends KinematicBody2D

export(int, "Easy", "Medium", "Hard", "INSANE") var DIFFICULTY = 1

var moveSpeed = 3
var yCompensate = 30
func _ready():
	match DIFFICULTY:
		0:
			moveSpeed = 4
		1:
			moveSpeed = 4.5
		2:
			moveSpeed = 5
		3:
			moveSpeed = 6
	moveSpeed *= 720.0 / GlobalVars.currentResolution[1]
	yCompensate = moveSpeed * 10
	pass

var prev_bPosx_predict = 0
var prev_bVel = Vector2(0, 0)
var prev_vel = Vector2(0, 0)

func _physics_process(delta):
	var ball = $"../Ball"
	if ball == null:
		for e in get_tree().root.get_children():
			print(e.name)
	var bVel = ball.linear_velocity
	if bVel[1] > 0 || ball.position[1] < self.position[1]:
		return
	if bVel != prev_bVel:
		prev_bVel = bVel
		var bPos = ball.position
		if bVel.length() != 0:
			var bPosx_predict = bPos[0] + abs((bPos[1] - 80) /  bVel[1]) *  bVel[0]
			bPosx_predict = clamp(bPosx_predict, 0, OS.window_size[0])
			if prev_bPosx_predict != bPosx_predict:
				#print("Predict: ", bPosx_predict)
				prev_bPosx_predict = bPosx_predict
				var dir = bPosx_predict - self.position[0]
				dir /= abs(dir)
				prev_vel = move_and_collide(Vector2(dir * abs(self.position[0] - bPosx_predict) * moveSpeed, 0) * delta)
				return
	#print("prev_vel ", prev_vel.length())
	var dir = prev_bPosx_predict - self.position[0]
	dir /= abs(dir)
	prev_vel = move_and_collide(Vector2(dir * abs(self.position[0] - prev_bPosx_predict) * moveSpeed, 0) * delta) 
