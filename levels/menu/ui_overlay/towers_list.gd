extends ItemList


@export var _tower_layer_resource_list: TowerLayerResource_List


func _ready() -> void:
	if _tower_layer_resource_list != null:
		fill(_tower_layer_resource_list)


func fill(tower_layer_resource_list: TowerLayerResource_List):
	self.clear()
	for tower_layer: TowerLayerResource in tower_layer_resource_list.tower_layer_resource_list:
		self.add_item(tower_layer.layer_name + " | cost: " + str(tower_layer.cost))
