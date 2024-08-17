class_name GameInfo_Resources
extends Node


signal on_resource_set

var _game_save_resources: GameSave_Resources


var people: int:
	set(value):
		people = value
		on_resource_set.emit()
var potato: int:
	set(value):
		potato = value
		on_resource_set.emit()
var carrot: int:
	set(value):
		carrot = value
		on_resource_set.emit()
var onion: int:
	set(value):
		onion = value
		on_resource_set.emit()
var herbs: int:
	set(value):
		herbs = value
		on_resource_set.emit()
var metal: int:
	set(value):
		metal = value
		on_resource_set.emit()
var research: int:
	set(value):
		research = value
		on_resource_set.emit()
var money: int:
	set(value):
		money = value
		on_resource_set.emit()


#! Check if it'sworking on _init()
func _ready() -> void:
	_game_save_resources = GameSave_Resources.load_or_create()
	
	if !_game_save_resources:
		printerr ("Game Resources, game_save == null")
		return
	
	people = _game_save_resources.people
	potato = _game_save_resources.potato
	carrot = _game_save_resources.carrot
	onion = _game_save_resources.onion
	herbs = _game_save_resources.herbs
	metal = _game_save_resources.metal
	research = _game_save_resources.research
	money = _game_save_resources.money
	
	print(_game_save_resources.people)


func save_game():
	_game_save_resources.people = people
	_game_save_resources.potato = potato
	_game_save_resources.carrot = carrot
	_game_save_resources.onion = onion
	_game_save_resources.herbs = herbs
	_game_save_resources.metal = metal
	_game_save_resources.research = research
	_game_save_resources.money = money
	
	_game_save_resources.save()
