extends Node


## Inforo that is stored while application is running
## Will be cleared after closing


var user_preferences: UserPreferences
#var game_save: GameSave


func _ready() -> void:
	user_preferences = UserPreferences.load_or_create() as UserPreferences
	#game_save = GameSave.load_or_create() as GameSave
