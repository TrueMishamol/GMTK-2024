extends Resource
class_name ResearchGoal

@export var unlocked: bool = false
@export var research_amount: int = 0

func attempt_unlock():
	if GameInfo.resources.research >= research_amount:
		GameInfo.resources.research -= research_amount
		unlocked = true
