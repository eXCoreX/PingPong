extends KinematicBody2D


export var moveSpeed = 50.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var prev_mPosx = 0
var new_vel
func _process(_delta):
	var mPos = get_global_mouse_position()
	if prev_mPosx != mPos[0]:
		var pos = self.position
		var dir = pos.direction_to(mPos)[0]
		if dir != 0:
			dir /= abs(dir)
		#print("mPosx = ", mPos[0], "prev_mPosx = ", prev_mPosx)
		new_vel = move_and_collide(Vector2(dir * abs(pos[0] - mPos[0]) * moveSpeed, 0))
	else:
		new_vel = move_and_collide(new_vel)
