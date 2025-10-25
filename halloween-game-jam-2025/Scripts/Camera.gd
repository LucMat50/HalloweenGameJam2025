extends Camera2D

var shake_intensity : float = 0.0

var shake_decay : float = 5.0

var shake_time : float = 0.0
var shake_time_speed : float = 1.0

var noise = FastNoiseLite.new()

var is_shaking : bool = false

func _physics_process(delta: float) -> void:
	if is_shaking:
		shake_time += delta * shake_time_speed
		
		offset = Vector2(
			noise.get_noise_2d(shake_time, 0) * shake_intensity,
			noise.get_noise_2d(0, shake_time) * shake_intensity
		)
		
	else:
		offset = lerp(offset, Vector2.ZERO, 10.5 * delta)
	
func start_screen_shake(intensity : int, speed : float) -> void:
	randomize()
	noise.seed = randi()
	noise.frequency = 2.0
	
	shake_intensity = intensity
	shake_time_speed = speed
	shake_time = 0.0
	is_shaking = true
	
func end_screen_shake() -> void:
	is_shaking = false
