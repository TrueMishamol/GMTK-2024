extends Node
class_name SceneLoader_Setup


@export var _scene_container: Node

# Menu
@export var _menu: CanvasLayer
var _menu_container: SceneLoader_MenuContainer
var _loading_menu_container: SceneLoader_MenuContainer
@export var _menu_container_template: PackedScene
var _animating: bool = false
var _queued_menu_to_load: String = ""


func load_game(scene_path: String):
	for child in _scene_container.get_children():
		child.queue_free()
	
	var scene: PackedScene = load(scene_path) as PackedScene
	var scene_instance = scene.instantiate()
	_scene_container.add_child(scene_instance)


func load_menu(scene_path: String):
	if _animating:
		_queued_menu_to_load = scene_path
		return
	_animating = true
	
	var menu_scene: PackedScene = load(scene_path) as PackedScene
	var menu_instance: Node = menu_scene.instantiate()
	
	_loading_menu_container = _menu_container_template.instantiate() as SceneLoader_MenuContainer

	_menu.add_child(_loading_menu_container)
	_loading_menu_container.add_child(menu_instance)
	
	_loading_menu_container.on_animation_finished.connect(_on_animation_finished)
	if _menu_container:
		_menu_container.fade_out()
	_loading_menu_container.fade_in()
	

func _on_animation_finished():
	_loading_menu_container.on_animation_finished.disconnect(_on_animation_finished)
	
	if _menu_container:
		_menu_container.queue_free()

	_menu_container = _loading_menu_container
	_loading_menu_container = null

	_animating = false
	
	if _queued_menu_to_load != "":
		load_menu(_queued_menu_to_load)
		_queued_menu_to_load = ""
