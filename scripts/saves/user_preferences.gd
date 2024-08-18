class_name UserPreferences
extends Resource


const USER_PREFERENCES_PATH: String = "user://user_preferences.tres"

signal on_user_preferences_save

@export_range(0, 1, .01) var master_audio_level: float = .5
@export_range(0, 1, .01) var music_audio_level: float = .5
@export_range(0, 1, .01) var sfx_audio_level: float = .5

@export var skip_boot_screen: bool = false


func save() -> void:
	ResourceSaver.save(self, USER_PREFERENCES_PATH)
	on_user_preferences_save.emit()


static func load_or_create() -> UserPreferences:
	var resource: UserPreferences
	if ResourceLoader.exists(USER_PREFERENCES_PATH):
		resource = load(USER_PREFERENCES_PATH) as UserPreferences
	if !resource:
		resource = UserPreferences.new()
		#resource.master_audio_level = 1
		#resource.music_audio_level = 1
		#resource.sfx_audio_level = 1
	return resource
