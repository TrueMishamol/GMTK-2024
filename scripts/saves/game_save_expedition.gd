class_name GameSave_Expedition
extends Resource


const GAME_SAVE_PATH: String = "user://expedition.tres"

signal on_save


@export var is_expedition_active: bool = false
@export var timer: float = 0
@export var people: int = 0
#! @export var destination: Destination = 


#func ensure_directory_exists(path: String) -> void:
	#var dir = DirAccess.open(path)
	#if dir and not dir.dir_exists(path):
		#var err = dir.make_dir_recursive(path)
		#if err != OK:
			#push_error("Failed to create directory: " + str(err))

#func save() -> void:
	#ensure_directory_exists(GAME_SAVE_PATH.get_base_dir())
	#
	#var err = ResourceSaver.save(self, GAME_SAVE_PATH)
	#if err != OK:
		#push_error("Failed to save file: " + str(err))
	#else:
		#on_save.emit()
		

func save() -> void:
	ResourceSaver.save(self, GAME_SAVE_PATH)
	on_save.emit()


static func load_or_create() -> GameSave_Expedition:
	var resource: GameSave_Expedition = load(GAME_SAVE_PATH) as GameSave_Expedition
	if !resource:
		resource = GameSave_Expedition.new()
	return resource
