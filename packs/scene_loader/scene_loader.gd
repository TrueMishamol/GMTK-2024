extends Node
## Put this in Autoload with name SceneLoader




## Put all Scene names here

const EMPTY_SCENE = "res://levels/empty_scene.tscn"

## Tree Scenes
## Name ends with _scene, load with load_tree()
const BOOT_SCENE = "res://levels/tree/boot_splash/boot_splash_2.tscn"
const BASE_GAME_SETUP = "res://levels/tree/base_game_setup/base_game_setup.tscn"
const MAIN_MENU_BACKGROUND = "res://levels/tree/main_menu_background/main_menu_background.tscn"

## Game Scenes
## Name ends with _game, load with load_game()
const GAME_LEVEL = "res://levels/game/game_level/game_level.tscn"

## Menu Scenes
## Name ends with _menu, load with load_menu()
const MAIN_MENU = "res://levels/menu/main_menu/main_menu.tscn"
const OPTIONS_MENU = "res://levels/menu/options_menu/options_menu.tscn"
const ABOUT_MENU = "res://levels/menu/about_menu/about_menu.tscn"

## Menu Overlay Scenes
## Name ends with _overlay, load with load_menu()
const UI_OVERLAY = "res://levels/menu/ui_overlay/ui_overlay.tscn"
const PAUSE_OVERLAY = "res://levels/menu/pause_overlay/pause_overlay.tscn"




## Breaks after moving folder
var _scene_loader_setup = preload("res://packs/scene_loader/scene_loader_setup.tscn")




signal on_game_load
signal on_menu_load
signal on_tree_load

var _scene_loader_instance: SceneLoader_Setup

var _menu_memory: Array[String] = []



func _ready() -> void:
	_scene_loader_instance = _scene_loader_setup.instantiate()
	add_child(_scene_loader_instance)


@rpc("authority", "call_local")
func load_tree(scene_path: String):
	get_tree().change_scene_to_file(scene_path)
	on_tree_load.emit()


func load_tree_network(scene_path: String):
	load_tree.rpc(scene_path)


@rpc("authority", "call_local")
func load_game(scene_path: String):
	_scene_loader_instance.load_game(scene_path)
	on_game_load.emit()
	

func load_game_network(scene_path: String):
	load_game.rpc(scene_path)
	

func load_menu(scene_path: String):
	_menu_memory.insert(0, scene_path)
	_scene_loader_instance.load_menu(scene_path)
	on_menu_load.emit()


func load_previous_menu():
	if _menu_memory.size() < 2: return
	load_menu(_menu_memory[1])
	_menu_memory.remove_at(0)
	_menu_memory.remove_at(0)
