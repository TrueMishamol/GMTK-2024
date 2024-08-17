extends Camera3D

# Speed and acceleration parameters
@export var move_speed: float = 400.0
@export var acceleration: float = 50.0
@export var deceleration: float = 100.0

# Limits for the Y position
@export var min_y: float = 3.0
@export var max_y: float = 100.0

# Current velocity
var velocity: float = 0.0

func _process(delta: float) -> void:
	if Input.is_action_pressed("down"):
		velocity -= acceleration * delta
	elif Input.is_action_pressed("up"):
		velocity += acceleration * delta
	else:
		# Decelerate when no input is pressed
		if velocity > 0:
			velocity = max(velocity - deceleration * delta, 0)
		elif velocity < 0:
			velocity = min(velocity + deceleration * delta, 0)

	# Apply the movement
	position.y += velocity * delta

	# Apply limits to the Y position
	position.y = clamp(position.y, min_y, max_y)

	# Clamp the velocity to avoid exceeding move_speed
	velocity = clamp(velocity, -move_speed, move_speed)
