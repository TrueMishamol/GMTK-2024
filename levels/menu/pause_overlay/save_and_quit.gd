extends Button


func _pressed() -> void:	
	SceneLoader.load_menu(SceneLoader.MAIN_MENU)
	SceneLoader.load_game(SceneLoader.EMPTY_SCENE)
	SceneLoader.load_tree(SceneLoader.EMPTY_SCENE)
	_save_game()

func _save_game():
	var game_save: GameSave = GameSave.load_or_create()
	
	#! I am not shure if float can be null / othervise use -1
	if DayNight.get_day_time() != null:
		game_save.day_time = DayNight.get_day_time()
		
	Inventory.try_save_inventory()
		
	game_save.save()
	
	
