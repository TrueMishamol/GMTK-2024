extends Resource
class_name tower_function


@export_group("Part Stats")
# Name of the part that will appear in UI
@export var partName:String
# Current level of the part
@export var partLevel:int = 1
# Maximum level the part can reach
@export var maxPartLevel:int = 3

@export_group("Upkeep Stats")
# Price to upkeep the part per in-game day
@export var upkeepPrice:int = 0

@export_group("Defense Stats")
# Current defense level of the part
@export var defenseLevel:int = 1
# Maximum defense level the part can reach
@export var maxDefenselevel:int = 5

@export_group("Research")
# The type of research that has to be done to unlock said part
@export var researchRequired:researchGoal
# If the part is already unlocked at start of new game
@export var unlockedAtBeginning:bool = true


func doTowerStuff():
	pass
