class_name GameInfo
extends Node


static var items: GameInfo_Items
static var expedition: GameInfo_Expedition
static var tower: GameInfo_Tower


func _ready() -> void:
	items = $Items
	expedition = $Expedition
	tower = $Tower


static func save_game():
	items.save_game()
	expedition.save_game()
	tower.save_game()
