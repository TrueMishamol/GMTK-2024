extends ItemList


@export var _tower_layer_resource_list: TowerLayerResource_List


func _ready() -> void:
	if _tower_layer_resource_list != null:
		_fill_info(_tower_layer_resource_list)
	
	item_activated.connect(_on_item_activated)


func _fill_info(tower_layer_resource_list: TowerLayerResource_List):
	self.clear()
	
	for tower_layer: TowerLayerResource in tower_layer_resource_list.tower_layer_resource_list:
		var text: String = ""
		text += tower_layer.layer_name + " | Item Cost: "
		
		if tower_layer.material_cost != null:
			text += str(tower_layer.cost) + " " + tower_layer.material_cost.name
		else:
			text += "Free"
			
		self.add_item(text)


func _on_item_activated(index: int):
	var tower_layer_resource: TowerLayerResource = _tower_layer_resource_list.tower_layer_resource_list[index]
	Tower.instance.try_buy_floor(tower_layer_resource)
	
