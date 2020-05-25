extends RigidBody2D

export var MIN_VEL = 350
export var MAX_VEL = 5000
export var INIT_VEL = 800

export(bool) var enableBoost = false

#var timer = Timer.new()

func _ready():
	MIN_VEL *= GlobalVars.currentResolution[1] / 720
	MAX_VEL *= GlobalVars.currentResolution[1] / 720
	INIT_VEL *= GlobalVars.currentResolution[1] / 720
	
	var rng = RandomNumberGenerator.new()
	#timer.connect("timeout", self, "print_velocity")
	#self.add_child(timer)
	#timer.start(1)
	rng.randomize()
	self.position = Vector2(rng.randi_range(50, GlobalVars.currentResolution[0]-50), GlobalVars.currentResolution[1] / 2)
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


func _on_Ball_body_entered(body):
	if enableBoost && body.name == "Player" && Input.is_mouse_button_pressed(1):
		self.apply_central_impulse(self.linear_velocity * 0.01)
	if body is KinematicBody2D:
		$PlatformSound.pitch_scale = 0.95 + randf()/10
		$PlatformSound.volume_db = 0 - exp((MAX_VEL / linear_velocity.length() - 1)) + 1
		$PlatformSound.play()
	else:
		$WallSound.pitch_scale = 0.95 + randf()/10
		$WallSound.volume_db = -3 - exp((MAX_VEL / linear_velocity.length() - 1)) + 1
		$WallSound.play()


func print_velocity():
	print(self.linear_velocity)
	print(self.linear_velocity.length())
