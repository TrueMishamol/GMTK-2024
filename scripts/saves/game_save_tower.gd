class_name GameSave_Tower
extends Resource


const GAME_SAVE_PATH: String = "user://tower.tres"

signal on_save


#! @export var floors: Array[FloorResource]


func save() -> void:
	ResourceSaver.save(self, GAME_SAVE_PATH)
	on_save.emit()


static func load_or_create() -> GameSave_Tower:
	var resource: GameSave_Tower
	if ResourceLoader.exists(GAME_SAVE_PATH):
		resource = load(GAME_SAVE_PATH) as GameSave_Tower
	if !resource:
		resource = GameSave_Tower.new()
	return resource
