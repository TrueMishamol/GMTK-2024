class_name GameInfo_Globals
extends Node


## Use GameInfo.globals to access this file


var _game_save: GameSave_Globals

var _sky: Node3D

var day_time: float:
	get:
		if _sky and is_instance_valid(_sky):
			day_time = _sky.day_time
		return day_time
var day_of_year: int:
	get:
		if _sky and is_instance_valid(_sky):
			day_of_year = _sky.day_of_year
		return day_of_year
		

func _init() -> void:
	_game_save = GameSave_Globals.load_or_create()
	if !_game_save:
		printerr ("Game Globals, game_save == null")
		return
	
	day_time = _game_save.day_time
	day_of_year = _game_save.day_of_year


#func _ready() -> void:
	#_sky.ondestroy


func set_sky(sky):
	_sky = sky


func save_game():
	_game_save.day_time = day_time
	_game_save.day_of_year = day_of_year
	
	_game_save.save()
