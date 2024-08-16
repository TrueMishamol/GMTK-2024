extends Node


var _is_game_paused = false


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	SceneLoader.on_game_load.connect(func(): toggle_game_pause(false))


func is_game_paused() -> bool:
	return _is_game_paused


func toggle_game_pause(is_paused: bool = !_is_game_paused):
	_is_game_paused = is_paused
	
	get_tree().paused = is_paused
