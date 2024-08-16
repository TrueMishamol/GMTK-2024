extends Node


func _ready() -> void:
	if SessionStorage.user_preferences.skip_boot_screen:
		SceneLoader.load_tree.call_deferred(SceneLoader.MAIN_MENU_BACKGROUND)
	else:
		SceneLoader.load_tree.call_deferred(SceneLoader.BOOT_SCENE)
	
	SceneLoader.load_menu(SceneLoader.MAIN_MENU)
