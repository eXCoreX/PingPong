extends RigidBody2D

export var MIN_VEL = 350
export var MAX_VEL = 5000
export var INIT_VEL = 800

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	self.position = Vector2(rng.randi_range(50, 1280-50), 720 / 2)
	var vx = randf() + 0.1
	var vy = randf() + 0.1
	if rng.randi_range(0, 1) == 0:
		vx *= -1
	if rng.randi_range(0, 1) == 0:
		vy *= -1
	self.linear_velocity = Vector2(vx, vy)
	self.linear_velocity = linear_velocity.normalized()*INIT_VEL


func _physics_process(_delta):
	if sleeping || self.linear_velocity.length() == 0:
		return
	if self.linear_velocity.length() < MIN_VEL:
		var coef = MIN_VEL / self.linear_velocity.length()
		self.linear_velocity *= coef
	if self.linear_velocity.length() > MAX_VEL:
		var coef = MAX_VEL / self.linear_velocity.length()
		self.linear_velocity *= coef
