class_name TowerList_Single
extends HBoxContainer



const bbcode_start: String = "[center][color=eedc54]"
const bbcode_end: String = "[/color] [/center]"

var _tower_floor_resource: TowerFloorResource

#@onready var _label: RichTextLabel = $Label
@onready var _buy: Button = $Buy
@onready var _label: RichTextLabel = $Label



func set_tower_floor_resource(tower_floor_resource: TowerFloorResource):
	_tower_floor_resource = tower_floor_resource
	
	_fill_in_text()
	
	_buy.pressed.connect(_on_buy_pressed)


func _fill_in_text():
	var text: String = ""
	text += bbcode_start
	text += _tower_floor_resource.layer_name
	text += bbcode_end
	text += "\nItem Cost: "
	if _tower_floor_resource.material_1 != null:
		text += str(_tower_floor_resource.cost_1) + " " + _tower_floor_resource.material_1.name
		if _tower_floor_resource.material_2 != null:
			text += ", " + str(_tower_floor_resource.cost_2) + " " + _tower_floor_resource.material_2.name
	else:
		text += "Free"
	if _tower_floor_resource.people_cost > 0:
		text += "\nPeople needed: " + str(_tower_floor_resource.people_cost)
	
	_label.text = text


func _on_buy_pressed():
	Tower.instance.try_buy_floor(_tower_floor_resource)
