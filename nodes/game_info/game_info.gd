class_name GameInfo
extends Node


static var globals: GameInfo_Globals
static var items: GameInfo_Items
static var expedition: GameInfo_Expedition
static var tower: GameInfo_Tower


func _ready() -> void:
	globals = $Globals
	items = $Items
	expedition = $Expedition
	tower = $Tower


static func save_game():
	globals.save_game()
	items.save_game()
	expedition.save_game()
	tower.save_game()
