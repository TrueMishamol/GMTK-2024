class_name FreeLookCamera extends Camera3D

# Modifier keys' speed multiplier
const SHIFT_MULTIPLIER = 2.5
const ALT_MULTIPLIER = 1.0 / SHIFT_MULTIPLIER

@export_group("Camera Values")
@export_range(0.0, 1.0) var sensitivity = 0.25
@export var default_position:Vector3
@export var max_distance_from_tower:float
@export var max_height:float

# Mouse state
var _mouse_position = Vector2(0.0, 0.0)
var _total_pitch = 0.0

# Movement state
var _direction = Vector3(0.0, 0.0, 0.0)
var _velocity = Vector3(0.0, 0.0, 0.0)
var _acceleration = 30
var _deceleration = -10
var _vel_multiplier = 4

# Keyboard state
var _w = false
var _s = false
var _a = false
var _d = false
var _q = false
var _e = false
var _shift = false
var _alt = false

func _input(event):
	# Receives mouse motion
	if event is InputEventMouseMotion:
		_mouse_position = event.relative
	
	# Receives mouse button input
	if Input.is_action_just_pressed("camera_rotate"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif Input.is_action_just_released("camera_rotate"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.is_action_just_pressed("reset_camera"):
		_reset_position(default_position)
		
	if Input.is_action_just_pressed("speed_increase"):
		_vel_multiplier = clamp(_vel_multiplier * 1.1, 0.2, 20)
		print("Speed increased: ", _vel_multiplier)
		
	if Input.is_action_just_pressed("speed_decrease"):
		_vel_multiplier = clamp(_vel_multiplier / 1.1, 0.2, 20)
		print("Speed decreased: ", _vel_multiplier)
	
	# Receives mouse button input
	#if event is InputEventMouseButton:
		#match event.button_index:
			#MOUSE_BUTTON_RIGHT: # Only allows rotation if right click down
				#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if event.pressed else Input.MOUSE_MODE_VISIBLE)
			#MOUSE_BUTTON_WHEEL_UP: # Increases max velocity
				#_vel_multiplier = clamp(_vel_multiplier * 1.1, 0.2, 20)
			#MOUSE_BUTTON_WHEEL_DOWN: # Decereases max velocity
				#_vel_multiplier = clamp(_vel_multiplier / 1.1, 0.2, 20)

	# Receives key input
	_w = Input.is_action_pressed("forward")
	_s = Input.is_action_pressed("back")
	_a = Input.is_action_pressed("left")
	_d = Input.is_action_pressed("right")
	_q = Input.is_action_pressed("down")
	_e = Input.is_action_pressed("up")
	
	# Receives key input
	#if event is InputEventKey:
		#match event.keycode:
			#KEY_W:
				#_w = event.pressed
			#KEY_S:
				#_s = event.pressed
			#KEY_A:
				#_a = event.pressed
			#KEY_D:
				#_d = event.pressed
			#KEY_Q:
				#_q = event.pressed
			#KEY_E:
				#_e = event.pressed

# Updates mouselook and movement every frame
func _process(delta):
	_update_movement(delta)
	_update_mouselook()
	position.y = clamp(position.y, 0.25, max_height)
	position.x = clamp(position.x, -max_distance_from_tower, max_distance_from_tower)
	position.z = clamp(position.z, -max_distance_from_tower, max_distance_from_tower)
	if (position.x >= max_distance_from_tower or 
		position.x <= -max_distance_from_tower or 
		position.z >= max_distance_from_tower or 
		position.z <= -max_distance_from_tower):
		_reset_position(default_position)


# Updates camera movement
func _update_movement(delta):
	# Computes desired direction from key states
	_direction = Vector3((_d as float) - (_a as float), 
						(_e as float) - (_q as float), 
						(_s as float) - (_w as float))
	
	# Computes the change in velocity due to desired direction and "drag"
	# The "drag" is a constant acceleration on the camera to bring it's velocity to 0
	var offset = _direction.normalized() * _acceleration * _vel_multiplier * delta \
		+ _velocity.normalized() * _deceleration * _vel_multiplier * delta
	
	# Compute modifiers' speed multiplier
	var speed_multi = 1
	if _shift: speed_multi *= SHIFT_MULTIPLIER
	if _alt: speed_multi *= ALT_MULTIPLIER
	
	# Checks if we should bother translating the camera
	if _direction == Vector3.ZERO and offset.length_squared() > _velocity.length_squared():
		# Sets the velocity to 0 to prevent jittering due to imperfect deceleration
		_velocity = Vector3.ZERO
	else:
		# Clamps speed to stay within maximum value (_vel_multiplier)
		_velocity.x = clamp(_velocity.x + offset.x, -_vel_multiplier, _vel_multiplier)
		_velocity.y = clamp(_velocity.y + offset.y, -_vel_multiplier, _vel_multiplier)
		_velocity.z = clamp(_velocity.z + offset.z, -_vel_multiplier, _vel_multiplier)
	
		translate(_velocity * delta * speed_multi)
	

# Updates mouse look 
func _update_mouselook():
	# Only rotates mouse if the mouse is captured
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_mouse_position *= sensitivity
		var yaw = _mouse_position.x
		var pitch = _mouse_position.y
		_mouse_position = Vector2(0, 0)
		
		# Prevents looking up/down too far
		pitch = clamp(pitch, -90 - _total_pitch, 90 - _total_pitch)
		_total_pitch += pitch
	
		rotate_y(deg_to_rad(-yaw))
		rotate_object_local(Vector3(1,0,0), deg_to_rad(-pitch))

func _reset_position(pos):
	position = pos
