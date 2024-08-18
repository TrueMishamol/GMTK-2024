extends VBoxContainer


@export var _resource_item_list: ResourceItem_List

#@on
#@onready var _title: Label = $Template/Title
#@onready var _count: Label = $Template/Count
@onready var _text: Label = $Text



func _ready() -> void:
	_update_info()
	
	GameInfo.resources.on_resource_set.connect(_update_info)


func _update_info():
	_text.text = ""
	for resource in _resource_item_list.resource_item_list:
		_text.text += resource.name + " " + str(GameInfo.resources.get_resource_item_count(resource.id)) + "\n"
	
	#_people.text = str(GameInfo.resources.people)
	#_potato.text = str(GameInfo.resources.potato)
	#_carrot.text = str(GameInfo.resources.carrot)
	#_onion.text = str(GameInfo.resources.onion)
	#_spices.text = str(GameInfo.resources.spices)
	#_metal.text = str(GameInfo.resources.metal)
	#_wood.text = str(GameInfo.resources.wood)
	#_fertile_soil.text = str(GameInfo.resources.fertile_soil)
	#_research.text = str(GameInfo.resources.research)
	#_money.text = str(GameInfo.resources.money)
