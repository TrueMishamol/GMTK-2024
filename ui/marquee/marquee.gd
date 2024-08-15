extends MarginContainer


enum Direction {
	UP, 	# 0
	DOWN,	# 1
	LEFT,	# 2 
	RIGHT,	# 3
}

@export var animation_speed: float = 1.0
@export var direction: Direction = Direction.UP
@export var content: Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var vertical_container: VBoxContainer = %VerticalContainer
@onready var horizontal_container: HBoxContainer = %HorizontalContainer

var _active_container: BoxContainer
var _direction_vector: Vector2
var _start_position: Vector2
var _height: float
var _width: float




func _ready():
	if content == null:
		printerr("Marquee content does't assigned")
		return
	
	_get_all_local_variables()
	
	content.reparent(_active_container)
	_active_container.add_child(content.duplicate())
	
	_setup_animation()


func _get_all_local_variables():
	_height = size.y
	_width = size.x
	
	match direction:
		0: 
			_direction_vector = Vector2.UP
			_active_container = vertical_container
		1: 
			_direction_vector = Vector2.DOWN
			_active_container = vertical_container
		2: 
			_direction_vector = Vector2.LEFT
			_active_container = horizontal_container
		3: 
			_direction_vector = Vector2.RIGHT
			_active_container = horizontal_container
			
	_start_position = _active_container.position
	


func _setup_animation():
	animation_player.speed_scale = animation_speed
	
	var animation: Animation
	
	match direction:
		Direction.UP:
			animation = animation_player.get_animation("marquee_animation_up")
			var track_index = animation.find_track("Control/VerticalContainer:position", Animation.TYPE_VALUE)
			animation.track_insert_key(track_index, 0, _start_position)
			animation.track_insert_key(track_index, 1, _start_position + Vector2.UP * _height)
			animation_player.play("marquee_animation_up")
		Direction.DOWN:
			animation = animation_player.get_animation("marquee_animation_down")
			var track_index = animation.find_track("Control/VerticalContainer:position", Animation.TYPE_VALUE)
			animation.track_insert_key(track_index, 0, _start_position + Vector2.UP * _height)
			animation.track_insert_key(track_index, 1, _start_position)
			animation_player.play("marquee_animation_down")
		Direction.LEFT:
			animation = animation_player.get_animation("marquee_animation_left")
			var track_index = animation.find_track("Control/HorizontalContainer:position", Animation.TYPE_VALUE)
			animation.track_insert_key(track_index, 0, _start_position)
			animation.track_insert_key(track_index, 1, _start_position + Vector2.LEFT * _width)
			animation_player.play("marquee_animation_left")
		Direction.RIGHT:
			animation = animation_player.get_animation("marquee_animation_right")
			var track_index = animation.find_track("Control/HorizontalContainer:position", Animation.TYPE_VALUE)
			animation.track_insert_key(track_index, 0, _start_position + Vector2.LEFT * _width)
			animation.track_insert_key(track_index, 1, _start_position)
			animation_player.play("marquee_animation_right")
	
	
