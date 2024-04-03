extends Camera2D

@export var randomStrength: float = 30.0  # Use "Strength" for consistency
@export var shakeFade: float = 5.0

var rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0

func apply_shake():
	shake_strength = randomStrength

func _ready():
	Events.balloon_poped.connect(apply_shake)


func _process(delta):
	#if Input.is_action_just_pressed("shake"):
		#apply_shake()
#	Events.balloon_poped.connect(apply_shake)

	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
		offset = random_offset()  

func random_offset() -> Vector2:
	
	return Vector2(
		rng.randf() * (shake_strength * 2.0) - shake_strength,
		rng.randf() * (shake_strength * 2.0) - shake_strength
	)
