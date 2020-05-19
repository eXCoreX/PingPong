extends KinematicBody2D


export var moveSpeed = 50.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var prev_mPosx = 0
var prev_vel
func _physics_process(delta):
	var mPos = get_global_mouse_position()
	mPos[0] = clamp(mPos[0], 1, OS.window_size[0] - 1)
	if prev_mPosx != mPos[0]:
		var pos = self.position
		var dir = pos.direction_to(mPos)[0]
		if dir != 0:
			dir /= abs(dir)
		#print("mPosx = ", mPos[0], "prev_mPosx = ", prev_mPosx)
		
		var tmp = move_and_collide(Vector2(dir * abs(pos[0] - mPos[0]) * moveSpeed, 0) * delta) 
		if tmp != null && !(tmp is KinematicCollision2D):
			prev_vel = tmp
	elif prev_vel != null:
		var tmp = move_and_collide(prev_vel * delta)
		if tmp != null && !(tmp is KinematicCollision2D):
			prev_vel = tmp
		
