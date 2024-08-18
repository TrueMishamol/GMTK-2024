class_name GameSave_Items
extends Resource


const GAME_SAVE_PATH: String = "user://items.tres"

signal on_save

@export var item_count_dictionary: Dictionary = {}



func save() -> void:
	ResourceSaver.save(self, GAME_SAVE_PATH)
	on_save.emit()


static func load_or_create() -> GameSave_Items:
	var resource: GameSave_Items
	if ResourceLoader.exists(GAME_SAVE_PATH):
		resource = load(GAME_SAVE_PATH) as GameSave_Items
	if !resource:
		resource = GameSave_Items.new()
	return resource
