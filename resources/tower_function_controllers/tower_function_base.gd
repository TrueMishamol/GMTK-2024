extends Resource
class_name TowerFunction


@export_group("Part Stats")
# Name of the part that will appear in UI
@export var part_name: String
# Current level of the part
@export var part_level: int = 1
# Maximum level the part can reach
@export var max_part_level: int = 3

@export_group("Upkeep Stats")
# Price to upkeep the part per in-game day
@export var upkeep_price: int = 0

@export_group("Defense Stats")
# Current defense level of the part
@export var defense_level: int = 1
# Maximum defense level the part can reach
@export var max_defense_level: int = 5

@export_group("Research")
# The type of research that has to be done to unlock said part
@export var research_required: ResearchGoal
# If the part is already unlocked at start of new game
@export var unlocked_at_beginning: bool = true


func do_tower_stuff():
	pass
