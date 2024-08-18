class_name GameSave_Globals
extends Resource


const GAME_SAVE_PATH: String = "user://globals.tres"

signal on_save


@export var day_time: float
@export var day_of_year: int


func save() -> void:
	ResourceSaver.save(self, GAME_SAVE_PATH)
	on_save.emit()


static func load_or_create() -> GameSave_Globals:
	var resource: GameSave_Globals
	if ResourceLoader.exists(GAME_SAVE_PATH):
		resource = load(GAME_SAVE_PATH) as GameSave_Globals
	if !resource:
		resource = GameSave_Globals.new()
		resource.day_time = 6
	return resource
