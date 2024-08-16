extends Button


func _ready() -> void:
	#! If controller
	#grab_focus()
	pass

func _pressed() -> void:
	SceneLoader.load_tree(SceneLoader.BASE_GAME_SETUP)
	SceneLoader.load_menu(SceneLoader.UI_OVERLAY)
	SceneLoader.load_game(SceneLoader.GAME_LEVEL)
