class_name Items_SingleUI
extends HBoxContainer


@onready var _sprite: TextureRect = $Sprite
@onready var _label: Label = $Label


func set_item(item_resource: ItemResource):
	_sprite.texture = item_resource.item_texture
	_label.text = item_resource.name + " " + str(GameInfo.items.get_item_resource_count(item_resource.id))
