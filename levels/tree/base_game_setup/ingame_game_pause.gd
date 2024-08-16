extends Node


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func _input(event):
	if event.is_action_pressed("menu"):
		_toggle_game_pause()


func _toggle_game_pause():
	GamePause.toggle_game_pause()
	var is_paused = GamePause.is_game_paused()
	
	if is_paused:
		SceneLoader.load_menu(SceneLoader.PAUSE_OVERLAY)
	else:
		SceneLoader.load_menu(SceneLoader.UI_OVERLAY)
