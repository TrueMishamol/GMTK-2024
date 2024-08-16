class_name GameSave
extends Resource


const GAME_SAVE_PATH: String = "user://game_save.tres"

signal on_game_save

@export var day_time: float = 0 #! Or maybe @export_range(0, 12, .05)


func save() -> void:
	ResourceSaver.save(self, GAME_SAVE_PATH)
	on_game_save.emit()


static func load_or_create() -> GameSave:
	var resource: GameSave = load(GAME_SAVE_PATH) as GameSave
	if !resource:
		resource = GameSave.new()
	return resource
