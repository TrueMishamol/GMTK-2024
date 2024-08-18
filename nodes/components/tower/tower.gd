class_name Tower
extends Node3D


@export var _basement_floor: TowerLayerResource

#var _list_of_unlocked_floors: Array[TowerLayerResource] # Save this in game save
var _list_of_floors: Array[TowerFloor]

static var instance: Tower


func _init() -> void:
	instance = self
	

func _ready() -> void:
	_load()
	

## Build floor & use resources
func try_buy_floor(tower_layer_resource: TowerLayerResource) -> bool:
	if tower_layer_resource == null:
		printerr("game.gd tower_layer_resource == null")
		return false
	if tower_layer_resource.scene_path == "":
		printerr("game.gd tower_layer_resource.scene == null")
		return false
	
	# If it's free
	if tower_layer_resource.material_cost == null:
		return true
	
	# If there are enough resources
	if GameInfo.resources.try_remove_item_count(tower_layer_resource.material_cost.id, tower_layer_resource.cost):
		_build_floor(tower_layer_resource)
		return true
	
	return false


## Builds floor without using resources 
func _build_floor(tower_layer_resource: TowerLayerResource):
	print("_build_floor " + tower_layer_resource.layer_name)
	
	# Get the new floor position
	var new_floor_position: Vector3
	if _list_of_floors.size() > 0:
		print(_list_of_floors.size())
		var previous_floor: TowerFloor = _list_of_floors[_list_of_floors.size() - 1] #! If there is 0 floors
		new_floor_position = previous_floor.get_tower_top_position()
	else:
		new_floor_position = self.position
	
	var new_floor_scene: PackedScene = load(tower_layer_resource.scene_path)
	var new_floor: TowerFloor = new_floor_scene.instantiate()

	# Add the new floor to the scene
	add_child(new_floor)
	new_floor.global_position = new_floor_position
	
	_list_of_floors.append(new_floor)
	

func _load():
	for child in get_children():
		if child.is_class(str(TowerFloor)): 
			child.queue_free()
	
	#! WIP
	#! If there is no save or smth => build_floor(_base_floor)
	_build_floor(_basement_floor)
	

func _save():
	#! WIP
	pass
