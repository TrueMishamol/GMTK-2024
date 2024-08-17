class_name GameInfo
extends Node


static var resources: GameInfo_Resources
static var expedition: GameInfo_Expedition
static var tower: GameInfo_Tower


func _ready() -> void:
	resources = $Resources
	expedition = $Expedition
	tower = $Tower


static func save_game():
	resources.save_game()
	expedition.save_game()
	tower.save_game()
