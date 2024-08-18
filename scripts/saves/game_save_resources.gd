class_name GameSave_Resources
extends Resource


const GAME_SAVE_PATH: String = "user://resources.tres"

signal on_save

@export var resource_count_dictionary: Dictionary = {}

@export var people: int = 10
@export var potato: int = 30
@export var carrot: int = 30
@export var onion: int = 30
@export var herbs: int = 0
@export var spices: int = 0
@export var metal: int = 0
@export var wood: int = 15
@export var fertile_soil: int = 5
@export var research: int = 100
@export var money: int = 100


func save() -> void:
	ResourceSaver.save(self, GAME_SAVE_PATH)
	on_save.emit()


static func load_or_create() -> GameSave_Resources:
	var resource: GameSave_Resources = load(GAME_SAVE_PATH) as GameSave_Resources
	if !resource:
		resource = GameSave_Resources.new()
	return resource
