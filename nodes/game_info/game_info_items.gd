class_name GameInfo_Items
extends Node


## Use GameInfo.items to access this file


signal on_item_set

@export var _item_resource_list: ItemResource_List

var _item_count_dictionary: Dictionary = {"empty": 0}

var _game_save_items: GameSave_Items



func set_item_resource_count(id: String, count: int):
	_item_count_dictionary[id] = count
	on_item_set.emit()


func add_item_resource_count(id: String, count: int):
	if _item_count_dictionary.has(id):
		_item_count_dictionary[id] += count
	else:
		_item_count_dictionary[id] = count
	on_item_set.emit()


func try_remove_item_count(id: String, count: int) -> bool:
	if !_item_count_dictionary.has(id):
		return false
	if count > _item_count_dictionary[id]:
		return false
	
	_item_count_dictionary[id] -= count
	on_item_set.emit()
	return true


## Dictionary{item_id: String, count: int}
func try_remove_multiple_item_count(item_id_count: Dictionary) -> bool:
	if !_is_enough_multiple_item_count(item_id_count):
		return false
	
	for id in item_id_count.keys():
		var count = item_id_count[id]

		_item_count_dictionary[id] -= count
		on_item_set.emit()
	
	return true


func _is_enough_multiple_item_count(item_id_count: Dictionary) -> bool:
	for id in item_id_count.keys():
		var count = item_id_count[id]
		
		if !_item_count_dictionary.has(id):
			return false
		if count > _item_count_dictionary[id]:
			return false
	
	return true


func get_item_resource_count(id: String) -> int:
	if _item_count_dictionary.has(id):
		return _item_count_dictionary[id]
	return 0





func _ready() -> void:
	_load_save() # Do not use on _init()


func _load_save():
	_game_save_items = GameSave_Items.load_or_create()
	if !_game_save_items:
		printerr ("Game Info Items, game_save == null")
		return
	
	_item_count_dictionary = _game_save_items.item_count_dictionary
	
	# Fill with default values if empty
	
	if _item_count_dictionary.size() == 0:
		print("_item_count_dictionary is empty. Fill it with default count values")
		if _item_resource_list == null:
			printerr("_item_resource_list == null")
			return
			
		for item in _item_resource_list.item_resource_list:
			_item_count_dictionary[item.id] = item.default_count


func save_game():
	_game_save_items.item_count_dictionary = _item_count_dictionary
	
	_game_save_items.save()
