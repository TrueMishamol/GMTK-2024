class_name GameInfo_Resources
extends Node


## Use GameInfo.resources to access this file


signal on_resource_set

@export var _resource_item_list: ResourceItem_List

var _resource_count_dictionary: Dictionary = {"empty": 0}

var _game_save_resources: GameSave_Resources



func set_resource_item_count(id: String, count: int):
	_resource_count_dictionary[id] = count
	on_resource_set.emit()


func add_resource_item_count(id: String, count: int):
	if _resource_count_dictionary.has(id):
		_resource_count_dictionary[id] += count
	else:
		_resource_count_dictionary[id] = count
	on_resource_set.emit()
	

func try_remove_item_count(id: String, count: int) -> bool:
	if !_resource_count_dictionary.has(id):
		return false
	if count > _resource_count_dictionary[id]:
		return false
	
	_resource_count_dictionary[id] -= count
	on_resource_set.emit()
	return true
	

func get_resource_item_count(id: String) -> int:
	if _resource_count_dictionary.has(id):
		return _resource_count_dictionary[id]
	return 0





func _init() -> void:
	_load_save()


func _load_save():
	_game_save_resources = GameSave_Resources.load_or_create()
	
	if !_game_save_resources:
		printerr ("Game Resources, game_save == null")
		return
	
	_resource_count_dictionary = _game_save_resources.resource_count_dictionary
	
	# WIP
	#for resource_item in _resource_item_list.resource_item_list:
		#_resource_count_dictionary[resource_item.id] = _game_save_resources.resource_count_dictionary[resource_item.id]
		#print(resource_item.name + " " + str(_resource_count_dictionary[resource_item.id]))


func save_game():
	_game_save_resources.resource_count_dictionary = _resource_count_dictionary
	
	_game_save_resources.save()
