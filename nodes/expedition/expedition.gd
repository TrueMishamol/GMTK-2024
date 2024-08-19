class_name Expedition
extends Node



const EXPEDITION_TIME: int = 10

static var instance: Expedition

var is_active: bool = false

@onready var _timer: Timer = $Timer

var _expedition_resource = null



func _init() -> void:
	instance = self


func _ready() -> void:
	_timer.timeout.connect(_on_timer_timeout)
	

func _on_timer_timeout():
	if _expedition_resource != null:
		finish_expedition()


func try_start_expedition_and_remove_items(expedition_resource: Expedition_Resource, people_count: int, time: int = EXPEDITION_TIME) -> bool:
	#! if Try remove items
		# start_expedition()
		# return true
	return false


func start_expedition(expedition_resource: Expedition_Resource, people_count: int, time: int = EXPEDITION_TIME):
	_expedition_resource = expedition_resource
	_timer.wait_time = time
	_timer.start()


func finish_expedition():
	_timer.stop()
