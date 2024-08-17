class_name GameInfo_Tower
extends Node


var _game_save: GameSave_Tower


#! var floors: Array[FloorResource]


#! Check if it'sworking on _init()
func _init() -> void:
	_game_save = GameSave_Tower.load_or_create()
	
	if !_game_save:
		printerr ("Game Resources, game_save == null")
		return
	
#! var floors: Array[FloorResource]


func save_game():
#! var floors: Array[FloorResource]
	
	_game_save.save()
