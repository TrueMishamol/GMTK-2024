extends VBoxContainer



@export var _item_resource_list: ItemResource_List

@onready var _template: Items_SingleUI = $Template



func _ready() -> void:
	_template.visible = false
	
	_update_info()
	GameInfo.items.on_item_set.connect(_update_info)


func _update_info():
	for child in get_children():
		if child != _template: 
			child.queue_free()
	
	for item_resource in _item_resource_list.item_resource_list:
		var instance = _template.duplicate() as Items_SingleUI
		add_child(instance)
		instance.visible = true
		instance.set_item(item_resource)
