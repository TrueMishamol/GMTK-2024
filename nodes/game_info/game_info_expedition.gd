class_name GameInfo_Expedition
extends Node


## Use GameInfo.expedition to access this file


signal on_expedition_set

var _game_save: GameSave_Expedition

var expedition: Expedition:
	set(value):
		expedition = value
		on_expedition_set.emit()

# Save this:
var is_expedition_active: bool = false
var timer: float = 0
var people: int = 0
var expedition_resource: Expedition_Resource



func _init() -> void:
	_game_save = GameSave_Expedition.load_or_create()
	if !_game_save:
		printerr ("Game Expedition, game_save == null")
		return
	
	is_expedition_active = _game_save.is_expedition_active
	timer = _game_save.timer
	people = _game_save.people
	#! destination: Destination


func save_game():
	_game_save.is_expedition_active = is_expedition_active
	_game_save.timer = timer
	_game_save.people = people
	#! destination: Destination
	
	_game_save.save()
