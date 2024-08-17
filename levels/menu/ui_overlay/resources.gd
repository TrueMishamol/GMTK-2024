extends VBoxContainer


@onready var _people: Label = $People/Count
@onready var _potato: Label = $Potato/Count
@onready var _carrot: Label = $Carrot/Count
@onready var _onion: Label = $Onion/Count
@onready var _spices: Label = $Spices/Count
@onready var _metal: Label = $Metal/Count
@onready var _wood: Label = $Wood/Count
@onready var _fertile_soil: Label = $FertileSoil/Count
@onready var _research: Label = $Research/Count
@onready var _money: Label = $Money/Count


func _ready() -> void:
	_update_info()
	
	GameInfo.resources.on_resource_set.connect(_update_info)


func _update_info():
	_people.text = str(GameInfo.resources.people)
	_potato.text = str(GameInfo.resources.potato)
	_carrot.text = str(GameInfo.resources.carrot)
	_onion.text = str(GameInfo.resources.onion)
	_spices.text = str(GameInfo.resources.spices)
	_metal.text = str(GameInfo.resources.metal)
	_wood.text = str(GameInfo.resources.wood)
	_fertile_soil.text = str(GameInfo.resources.fertile_soil)
	_research.text = str(GameInfo.resources.research)
	_money.text = str(GameInfo.resources.money)
