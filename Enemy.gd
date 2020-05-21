extends KinematicBody2D

export(int, "Easy", "Medium", "Hard", "INSANE") var DIFFICULTY = 1

var moveSpeed = 3
#var yCompensate = 30
func _ready():
	DIFFICULTY = GlobalVars.currentDifficulty
	match DIFFICULTY:
		0:
			moveSpeed = 4
		1:
			moveSpeed = 4.5
		2:
			moveSpeed = 5
		3:
			moveSpeed = 6
#	yCompensate = moveSpeed * 10
	moveSpeed *= GlobalVars.currentResolution[1] / 720.0
	self.position[0] = GlobalVars.currentResolution[0] / 2

	pass

var prev_bPosx_predict = 0
var prev_bVel = Vector2(0, 0)
var prev_vel = Vector2(0, 0)

func _physics_process(delta):
	var ball = $"..".find_node("Ball", false, false)
	if ball == null:
		return
	var bVel = ball.linear_velocity
	if bVel[1] > 0 || ball.position[1] < self.position[1] - 100:
		return
	if bVel != prev_bVel:
		prev_bVel = bVel
		var bPos = ball.position
		if bVel.length() != 0:
			var selfShape = $CollisionShape2D.shape as CapsuleShape2D
			var ballShape = $"../Ball/CollisionShape2D".shape as CircleShape2D
			var bPosx_predict = bPos[0] + ((bPos[1] - ballShape.radius - self.position[1] - selfShape.radius) / (-bVel[1])) *  bVel[0]
			bPosx_predict = clamp(bPosx_predict, 0, OS.window_size[0])
			print(bPosx_predict)
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
