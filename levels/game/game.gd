extends Node3D



@export var _tower_layer_resource_list: TowerLayerResource_List

var _last_placed_tower_piece: Node3D = null
# The selected tower piece scene to place
#var _selected_piece_scene: PackedScene = null #! User TowerLayerResource


# Wave state variable
var _night_wave_active: bool = false






func _process(delta):
	#! WIP
		#.connect("item_activated", tower_selected)
		#update_item_list_text_with_cost()
	if _night_wave_active:
		_check_enemies_defeated()






#------------------#
# Building a Tower #
#------------------#

## Function to handle placing the selected tower piece
#func _try_place_tower_layer(tower_layer_resource: TowerLayerResource):
	#if tower_layer_resource == null:
		#printerr("game.gd tower_layer_resource == null")
		#return
	#if tower_layer_resource.scene == null:
		#printerr("game.gd tower_layer_resource.scene == null")
		#return
#
#
	#
	## If there's a last placed piece, use its placement function
	#if _last_placed_tower_piece != null:
		#if _last_placed_tower_piece.instantiate_tower_piece(_selected_piece_scene):
			## Successfully placed the piece, so update the last placed piece
			#_last_placed_tower_piece = _last_placed_tower_piece.get_child(0).get_child(0)
			#print("Piece placed successfully.")
		#else:
			#print("Failed to place the selected piece.")
	#else:
		## If no last piece, place the first piece at the origin or a defined start point
		#var _new_piece = _selected_piece_scene.instantiate()
		#if _new_piece != null and _new_piece is Node3D:
			#_new_piece.global_transform.origin = Vector3(0, 0, 0) # Adjust this position as needed
			#get_tree().root.add_child(_new_piece)
			#_last_placed_tower_piece = _new_piece
			#print("First piece placed successfully.")
		#else:
			#print("Failed to instantiate the first piece.")
#
#
#
#
## Function to set the selected piece scene
#func _set_selected_piece_scene(scene: PackedScene):
	#_selected_piece_scene = scene
	#print("Selected piece scene set.")
	#
	#_try_place_tower_layer(_selected_piece_scene)




#-------------#
# Night Waves #
#-------------#

# Function to start the night wave
func _start_night_wave():
	_night_wave_active = true
	print("Night wave started!")
	# Additional logic for starting the wave (e.g., spawning enemies) can be added here


# Function to end the night wave
func _end_night_wave():
	_night_wave_active = false
	print("Night wave ended!")
	# Additional logic for ending the wave (e.g., calculating rewards) can be added here


# Function to check if all enemies are defeated
func _check_enemies_defeated():
	if _night_wave_active:
		var enemies = get_tree().get_nodes_in_group("Enemy")
		if enemies.size() == 0:
			_end_night_wave()
