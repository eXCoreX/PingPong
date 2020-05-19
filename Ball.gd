extends RigidBody2D

export var MIN_VEL = 350
export var MAX_VEL = 5000
export var INIT_VEL = 800


# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.seed = hash(OS.get_datetime())
	var window_size = OS.window_size
	self.position = Vector2(rng.randi_range(50, window_size[0]), window_size[1] / 2)
	self.linear_velocity = Vector2(randf() - randf(), randf() - randf())
	self.linear_velocity = linear_velocity.normalized()*INIT_VEL
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if self.linear_velocity.length() < MIN_VEL:
		var coef = MIN_VEL / self.linear_velocity.length()
		self.linear_velocity *= coef
	if self.linear_velocity.length() > MAX_VEL:
		var coef = MAX_VEL / self.linear_velocity.length()
		self.linear_velocity *= coef
