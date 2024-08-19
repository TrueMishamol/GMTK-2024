class_name TowerFloorResource
extends Resource


@export var layer_name: String
@export_file("*.tscn") var scene_path: String ## Must be TowerFloor

@export var build_time: int = 5

@export_group("Material Cost")
@export var people_cost: int
@export var material_1: ItemResource
@export var cost_1: int
@export var material_2: ItemResource
@export var cost_2: int

@export_group("On future updates")
@export var reseatch_cost: int = 5 ## How many research points to spend to unlock this floor
@export var unlocked_at_beginning: bool = false
@export var max_part_level: int = 3
@export var upkeep_price: int = 0
@export var max_defense_level: int = 5
