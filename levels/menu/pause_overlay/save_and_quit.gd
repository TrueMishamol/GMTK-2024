extends Button


func _pressed() -> void:	
	SceneLoader.load_menu(SceneLoader.MAIN_MENU)
	SceneLoader.load_game(SceneLoader.EMPTY_SCENE)
	SceneLoader.load_tree(SceneLoader.MAIN_MENU_BACKGROUND)
	_save_game()

func _save_game():
	GameInfo.save_game()
	
	var game_save: GameSave = GameSave.load_or_create()
	
	game_save.save()
	
	
