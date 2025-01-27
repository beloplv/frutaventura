extends Camera2D

var decay := 0.10
var max_offset := Vector2(10,10)
@export var noise : FastNoiseLite

var noise_y = 0 

var trauma := 0.0 
var trauma_pwr := 2

func _ready():
	Game.camera = self
	reset_smoothing()
	randomize()
	noise.seed = randi()

func add_trauma(amount : float):
	trauma = min(trauma + amount, 1.0)

func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()

	elif offset.x != 0 or offset.y != 0:
		lerp(offset.x,0.0,1)
		lerp(offset.y,0.0,1)

func shake(): 
	var amt = pow(trauma, trauma_pwr)
	noise_y += 1
	offset.x = max_offset.x * amt * noise.get_noise_2d(noise.seed*2,noise_y)
	offset.y = max_offset.y * amt * noise.get_noise_2d(noise.seed*3,noise_y)
