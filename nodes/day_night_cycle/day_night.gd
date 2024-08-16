class_name DayNight
extends Node3D


@onready var _animation: AnimationPlayer = %AnimationPlayer
static var _day_night: DayNight

func _ready() -> void:
	_day_night = self
	var time = GameSave.load_or_create().day_time
	_set_day_time(time)

static func get_day_time() -> float:
	#! if doesn't existing on the scene - return null
	#! I am not sure if float can be null / othervise use -1
	#fix in save & quit
	return _day_night._get_time()

func _set_day_time(time: float):
	_day_night._set_time(time)

func _get_time() -> float:
	var time: float = randf()
	time = _animation.current_animation_position
	return time

func _set_time(time: float):
	_animation.seek(time)
