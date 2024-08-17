class_name GameInfo_Resources
extends Node


## Use GameInfo.resources to access this file


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
var spices: int:
	set(value):
		spices = value
		on_resource_set.emit()
var metal: int:
	set(value):
		metal = value
		on_resource_set.emit()
var wood: int:
	set(value):
		wood = value
		on_resource_set.emit()
var fertile_soil: int:
	set(value):
		fertile_soil = value
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
	spices = _game_save_resources.spices
	metal = _game_save_resources.metal
	wood = _game_save_resources.wood
	fertile_soil = _game_save_resources.fertile_soil
	research = _game_save_resources.research
	money = _game_save_resources.money
	
	print(_game_save_resources.people)


func save_game():
	_game_save_resources.people = people
	_game_save_resources.potato = potato
	_game_save_resources.carrot = carrot
	_game_save_resources.onion = onion
	_game_save_resources.spices = spices
	_game_save_resources.metal = metal
	_game_save_resources.wood = wood
	_game_save_resources.fertile_soil = fertile_soil
	_game_save_resources.research = research
	_game_save_resources.money = money
	
	_game_save_resources.save()
