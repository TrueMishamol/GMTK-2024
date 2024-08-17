class_name GameSave
extends Resource


const GAME_SAVE_PATH: String = "user://game_save.tres"

signal on_game_save

@export var day_time: float = 0 #! Or maybe @export_range(0, 12, .05)

@export var people: int = 10
@export var potato: int = 30
@export var carrot: int = 30
@export var onion: int = 30
@export var herbs: int = 0
@export var metal: int = 0
@export var research: int = 100
@export var money: int = 100


func save() -> void:
	ResourceSaver.save(self, GAME_SAVE_PATH)
	on_game_save.emit()


static func load_or_create() -> GameSave:
	var resource: GameSave = load(GAME_SAVE_PATH) as GameSave
	if !resource:
		resource = GameSave.new()
	return resource
