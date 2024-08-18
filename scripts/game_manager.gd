#class_name  GameManager
extends Node

# Put this script in autoload

func try_buy_tower_layer(tower_layer_resource: TowerLayerResource) -> bool:
	if tower_layer_resource.material_cost == null:
		return false
	return GameInfo.resources.try_remove_item_count(tower_layer_resource.material_cost.id, tower_layer_resource.cost)
