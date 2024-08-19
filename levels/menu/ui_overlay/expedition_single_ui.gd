extends Control



@export var _expedition_resource: Expedition_Resource

@onready var _people_slider: HSlider = $VBoxContainer/PeopleSlider
@onready var _start: Button = $VBoxContainer/Start



func _ready() -> void:
	_people_slider.max_value = GameInfo.items.get_item_resource_count("people") #! Hardcoded
	
	_start.pressed.connect(on_start_pressed)
	
	GameInfo.expedition.on_expedition_set.connect(_try_connect_expedition)
	_try_connect_expedition()


func _try_connect_expedition():
	if GameInfo.expedition.expedition == null:
		_start.visible = false
		return
	else:
		_start.visible = true
		
	_start.visible = !GameInfo.expedition.expedition.is_active
	
	GameInfo.expedition.expedition.on_expedition_start.connect(_on_expedition_start)
	GameInfo.expedition.expedition.on_expedition_end.connect(_on_expedition_end)


func on_start_pressed() -> void:
	if GameInfo.expedition.expedition == null:
		return
	GameInfo.expedition.expedition.try_start_expedition_and_remove_people(_expedition_resource, _people_slider.value)

func _on_expedition_start():
	_start.visible = false
	

func _on_expedition_end():
	_start.visible = true
	
	
