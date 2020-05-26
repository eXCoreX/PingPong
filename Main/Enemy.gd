extends KinematicBody2D

export(int, "Easy", "Medium", "Hard", "INSANE") var DIFFICULTY = 1

var moveSpeed = 3
#var yCompensate = 30
func _ready():
	DIFFICULTY = GlobalVars.currentDifficulty
	match DIFFICULTY:
		0:
			moveSpeed = 3
		1:
			moveSpeed = 4
		2:
			moveSpeed = 5
		3:
			moveSpeed = 6
#	yCompensate = moveSpeed * 10
	self.position[0] = GlobalVars.currentResolution[0] / 2


var prev_bPosx_predict = 0
var prev_bVel = Vector2(0, 0)
var prev_vel = Vector2(0, 0)

func _physics_process(delta):
	var ball = $"..".find_node("Ball", false, false) # Find ball
	if ball == null: # Not found
		return
	var bVel = ball.linear_velocity
	if bVel[1] > 0 || ball.position[1] < self.position[1] - 100: # The ball is moving toward the player, or is beyond reach.
		return
	if bVel != prev_bVel: # If velocity is changed
		prev_bVel = bVel
		var bPos = ball.position
		if bVel.length() != 0: # If ball is moving at all
			var selfShape = $CollisionShape2D.shape as CapsuleShape2D
			var ballShape = $"../Ball/CollisionShape2D".shape as CircleShape2D
			var bPosx_predict = bPos[0] + ((bPos[1] - ballShape.radius - self.position[1] 
											- selfShape.radius) / (-bVel[1])) *  bVel[0] # Predicting ball's intersection
			bPosx_predict = clamp(bPosx_predict, 0, OS.window_size[0])
			if prev_bPosx_predict != bPosx_predict: # If prediction is changed
				#print("Predict: ", bPosx_predict)
				prev_bPosx_predict = bPosx_predict
				prev_vel = move_and_collide(Vector2((bPosx_predict - self.position[0]) * moveSpeed, 0) * delta)
				return
	#print("prev_vel ", prev_vel.length())
	prev_vel = move_and_collide(Vector2((prev_bPosx_predict - self.position[0]) * moveSpeed, 0) * delta) 
