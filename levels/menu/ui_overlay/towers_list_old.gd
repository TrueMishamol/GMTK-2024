extends ItemList


@export var _tower_floor_resource_list: TowerFloorResource_List


func _ready() -> void:
	if _tower_floor_resource_list != null:
		_fill_info(_tower_floor_resource_list)
	
	item_activated.connect(_on_item_activated)


func _fill_info(tower_floor_resource_list: TowerFloorResource_List):
	self.clear()
	
	for tower_floor: TowerFloorResource in tower_floor_resource_list.tower_floor_resource_list:
		var text: String = ""
		text += tower_floor.layer_name + " | Item Cost: "
		

		if tower_floor.material_1 != null:
			text += ", " + str(tower_floor.cost_1) + " " + tower_floor.material_1.name
		if tower_floor.material_2 != null:
			text += ", " + str(tower_floor.cost_2) + " " + tower_floor.material_2.name
		else:
			text += "Free"
		if tower_floor.people_cost > 0:
			text += " | People needed: " + str(tower_floor.people_cost)
		
		self.add_item(text)


func _on_item_activated(index: int):
	var tower_floor_resource: TowerFloorResource = _tower_floor_resource_list.tower_floor_resource_list[index]
	Tower.instance.try_buy_floor(tower_floor_resource)
	
