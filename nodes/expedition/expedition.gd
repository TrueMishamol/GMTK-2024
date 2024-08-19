class_name Expedition
extends Node


signal on_expedition_start
signal on_expedition_end


#static var instance: Expedition

var is_active: bool = false
var _people_count: int
var _expedition_resource: Expedition_Resource = null

@onready var timer: Timer = $Timer




func _init() -> void:
	#instance = self
	GameInfo.expedition.expedition = self


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	

func _on_timer_timeout():
	if _expedition_resource != null:
		finish_expedition()


func try_start_expedition_and_remove_people(expedition_resource: Expedition_Resource, people_count: int) -> bool:
	if is_active:
		return false
		
	if GameInfo.items.try_remove_item_count("people", people_count): #! Harcoded:
		start_expedition(expedition_resource, people_count)
		return true
		
	return false


func start_expedition(expedition_resource: Expedition_Resource, people_count: int):
	print("Expedition started: " + expedition_resource.expedition_name)
	_expedition_resource = expedition_resource
	timer.wait_time = expedition_resource.expedition_time
	timer.start()
	is_active = true
	on_expedition_start.emit()
	_people_count = people_count


func finish_expedition():
	print("Expedition finished: " + _expedition_resource.expedition_name)
	is_active = false
	timer.stop()
	
	# Randomize People count
	var min_people_count: float = _people_count * 0.9  # 10% trimmed
	var max_people_count: float = _people_count * 0.5  # 50% trimmed
	var output_people_count = randi_range(min_people_count, max_people_count)
	output_people_count = floor(output_people_count) # Round down to the nearest integer
	GameInfo.items.add_item_resource_count("people", output_people_count) #! Hardcoded
	
	# Randomize Items count
	for reward_item in _expedition_resource.reward_items:
		var min_items_count: float = output_people_count
		var max_items_count: float = output_people_count * 5
		var output_items_count: float = randi_range(min_items_count, max_items_count)
		output_items_count = floor(output_items_count) # Round down to the nearest integer
		GameInfo.items.add_item_resource_count(reward_item.id, output_items_count)
	
	on_expedition_end.emit()
