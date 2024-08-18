extends ItemList


@export var _tower_floor_resource_list: TowerLayerResource_List


func _ready() -> void:
	if _tower_floor_resource_list != null:
		_fill_info(_tower_floor_resource_list)
	
	item_activated.connect(_on_item_activated)


func _fill_info(tower_floor_resource_list: TowerLayerResource_List):
	self.clear()
	
	for tower_floor: TowerLayerResource in tower_floor_resource_list.tower_floor_resource_list:
		var text: String = ""
		text += tower_floor.layer_name + " | Item Cost: "
		
		if tower_floor.material_cost != null:
			text += str(tower_floor.cost) + " " + tower_floor.material_cost.name
		else:
			text += "Free"
			
		self.add_item(text)


func _on_item_activated(index: int):
	var tower_floor_resource: TowerLayerResource = _tower_floor_resource_list.tower_floor_resource_list[index]
	Tower.instance.try_buy_floor(tower_floor_resource)
	
