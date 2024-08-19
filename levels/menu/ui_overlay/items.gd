extends VBoxContainer


@export var _item_resource_list: ItemResource_List

#@on
#@onready var _title: Label = $Template/Title
#@onready var _count: Label = $Template/Count
@onready var _text: Label = $Text



func _ready() -> void:
	_update_info()
	
	GameInfo.items.on_item_set.connect(_update_info)


func _update_info():
	_text.text = ""
	for item in _item_resource_list.item_resource_list:
		_text.text += item.name + " " + str(GameInfo.items.get_item_resource_count(item.id)) + "\n"
	
	#_people.text = str(GameInfo.items.people)
	#_potato.text = str(GameInfo.items.potato)
	#_carrot.text = str(GameInfo.items.carrot)
	#_onion.text = str(GameInfo.items.onion)
	#_spices.text = str(GameInfo.items.spices)
	#_metal.text = str(GameInfo.items.metal)
	#_wood.text = str(GameInfo.items.wood)
	#_fertile_soil.text = str(GameInfo.items.fertile_soil)
	#_research.text = str(GameInfo.items.research)
	#_money.text = str(GameInfo.items.money)
