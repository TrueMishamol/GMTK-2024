extends Node



@export var _tower_floor_resource_list: TowerFloorResource_List

@export var _template: TowerList_Single



func _ready() -> void:
	_template.visible = false
	if _tower_floor_resource_list != null:
		_fill_info()


func _fill_info():
	for child in get_children():
		if child != _template: 
			child.queue_free()
	
	for tower_floor_resource: TowerFloorResource in _tower_floor_resource_list.tower_floor_resource_list:
		var instance = _template.duplicate()
		add_child(instance)
		instance.visible = true
		instance.set_tower_floor_resource(tower_floor_resource)
