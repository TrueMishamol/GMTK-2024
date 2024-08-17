extends VBoxContainer


@onready var _people: Label = $People/Count
@onready var _potato: Label = $Potato/Count
@onready var _carrot: Label = $Carrot/Count
@onready var _onion: Label = $Onion/Count
@onready var _herbs: Label = $Herbs/Count
@onready var _metal: Label = $Metal/Count
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
	_herbs.text = str(GameInfo.resources.herbs)
	_metal.text = str(GameInfo.resources.metal)
	_research.text = str(GameInfo.resources.research)
	_money.text = str(GameInfo.resources.money)
