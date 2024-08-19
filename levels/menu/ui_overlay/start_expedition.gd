extends Control



@export var _expedition_resource: Expedition_Resource

@onready var _people_slider: HSlider = $VBoxContainer/PeopleSlider
@onready var _start: Button = $VBoxContainer/Start



func _ready() -> void:
	_people_slider.max_value = GameInfo.items.get_item_resource_count("people") #! Hardcoded
	
	_start.pressed.connect(on_start_pressed)


func on_start_pressed() -> void:
	Expedition.instance.try_start_expedition_and_remove_items(_expedition_resource, _people_slider.value)
