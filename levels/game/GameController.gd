extends Node3D

# Stores the last placed tower piece
@export var _last_placed_piece: Node3D = null

# The selected tower piece scene to place
var _selected_piece_scene: PackedScene = null

# Wave state variable
var _night_wave_active: bool = false

@onready var _tower_list_tab:ItemList = null
@export var tower_layers: Array[TowerLayerResource] = []

# Function to update the ItemList text with material cost
func update_item_list_text_with_cost():
	for index in range(_tower_list_tab.get_item_count()):
		var item_text = _tower_list_tab.get_item_text(index)
		
		# Find the corresponding TowerLayerResource for this item
		var layer_resource = get_tower_layer_resource_by_name(remove_text_after_pipe(item_text))
		if layer_resource:
			var cost_text = "Material Cost: "
			var material_costs = []
			
			for item in layer_resource.material_cost:
				material_costs.append(item.name + ": " + str(item.amount))

			if material_costs.size() > 0:
				cost_text += ", ".join(material_costs)
			else:
				cost_text += "Free"
			# Update the item text with material cost at the end
			var updated_text = layer_resource.layer_name + " | " + cost_text
			_tower_list_tab.set_item_text(index, updated_text)
			print("Updated item at index ", index, " to: ", updated_text)

# Helper function to get TowerLayerResource by layer name
func get_tower_layer_resource_by_name(name: String) -> TowerLayerResource:
	for resource in tower_layers:
		if resource.layer_name == name:
			return resource
	return null

# Function to check if there are enough materials
func has_sufficient_materials(material_cost: Array[InventoryResourceItem]) -> bool:
	# Iterate through each item in the material cost
	for item in material_cost:
		if not has_enough_material(item):
			return false
	
	return true

# Helper function to check if there is enough of a specific material
func has_enough_material(item: InventoryResourceItem) -> bool:
	match item.name:
		"Potato":
			return GameInfoAutoload.resources.potato >= item.amount
		"Carrot":
			return GameInfoAutoload.resources.carrot >= item.amount
		"Onion":
			return GameInfoAutoload.resources.onion >= item.amount
		"Herbs":
			return GameInfoAutoload.resources.herbs >= item.amount
		"Spices":
			return GameInfoAutoload.resources.spices >= item.amount
		"Metal":
			return GameInfoAutoload.resources.metal >= item.amount
		"Soil":
			return GameInfoAutoload.resources.fertile_soil >= item.amount
		"Wood":
			return GameInfoAutoload.resources.wood >= item.amount
		"Research":
			return GameInfoAutoload.resources.research >= item.amount
		"Money":
			return GameInfoAutoload.resources.money >= item.amount
		_:
			print("Unknown material: ", item.name)
			return false

# Function to start the night wave
func start_night_wave():
	_night_wave_active = true
	print("Night wave started!")
	# Additional logic for starting the wave (e.g., spawning enemies) can be added here

# Function to end the night wave
func end_night_wave():
	_night_wave_active = false
	print("Night wave ended!")
	# Additional logic for ending the wave (e.g., calculating rewards) can be added here

# Function to check if all enemies are defeated
func check_enemies_defeated():
	if _night_wave_active:
		var enemies = get_tree().get_nodes_in_group("Enemy")
		if enemies.size() == 0:
			end_night_wave()

# Function to handle placing the selected tower piece
func place_selected_piece():
	if _selected_piece_scene == null:
		print("No selected piece scene to place.")
		return
	
	# If there's a last placed piece, use its placement function
	if _last_placed_piece != null:
		if _last_placed_piece.instantiate_tower_piece(_selected_piece_scene):
			# Successfully placed the piece, so update the last placed piece
			_last_placed_piece = _last_placed_piece.get_child(0).get_child(0)
			print("Piece placed successfully.")
		else:
			print("Failed to place the selected piece.")
	else:
		# If no last piece, place the first piece at the origin or a defined start point
		var _new_piece = _selected_piece_scene.instantiate()
		if _new_piece != null and _new_piece is Node3D:
			_new_piece.global_transform.origin = Vector3(0, 0, 0) # Adjust this position as needed
			get_tree().root.add_child(_new_piece)
			_last_placed_piece = _new_piece
			print("First piece placed successfully.")
		else:
			print("Failed to instantiate the first piece.")

# Function to set the selected piece scene
func set_selected_piece_scene(scene: PackedScene):
	_selected_piece_scene = scene
	print("Selected piece scene set.")
	
func tower_selected(tower_id: int):
	set_selected_piece_scene(null)
	match remove_text_after_pipe(_tower_list_tab.get_item_text(tower_id)):
		"Carrot Farm":
			set_selected_piece_scene(tower_layers[0].scene) # Adjust index as needed
		"Carrot Shop":
			set_selected_piece_scene(tower_layers[1].scene) # Adjust index as needed
		"Onion Farm":
			set_selected_piece_scene(tower_layers[3].scene) # Adjust index as needed
		"Onion Shop":
			set_selected_piece_scene(tower_layers[4].scene) # Adjust index as needed
		"Potato Farm":
			set_selected_piece_scene(tower_layers[5].scene) # Adjust index as needed
		"Potato Shop":
			set_selected_piece_scene(tower_layers[6].scene) # Adjust index as needed
		"House":
			set_selected_piece_scene(tower_layers[2].scene) # Adjust index as needed
		#"Barracks Layer":
			#if _last_placed_piece and _last_placed_piece.name == "Defense Layer":
				#set_selected_piece_scene(tower_layers[5].scene) # Adjust index as needed
			#else:
				#print("Barracks requires the Defense Layer below it.")
		#"Temple Layer":
			#set_selected_piece_scene(tower_layers[6].scene) # Adjust index as needed
		#"Engineering Layer":
			#if _last_placed_piece and _last_placed_piece.name == "Workshop Layer":
				#set_selected_piece_scene(tower_layers[7].scene) # Adjust index as needed
			#else:
				#print("Engineering requires the Workshop Layer below it.")
		#"Observation Deck":
			#if _last_placed_piece and _last_placed_piece.name == "Defense Layer":
				#set_selected_piece_scene(tower_layers[8].scene) # Adjust index as needed
			#else:
				#print("Observation Deck requires the Defense Layer below it.")
		#"Storage Layer":
			#set_selected_piece_scene(tower_layers[9].scene) # Adjust index as needed
		#"Alchemy Lab":
			#if _last_placed_piece and _last_placed_piece.name == "Library Layer":
				#set_selected_piece_scene(tower_layers[10].scene) # Adjust index as needed
			#else:
				#print("Alchemy Lab requires the Library Layer below it.")
		#"Greenhouse":
			#if _last_placed_piece and _last_placed_piece.name == "Agriculture Layer":
				#set_selected_piece_scene(tower_layers[11].scene) # Adjust index as needed
			#else:
				#print("Greenhouse requires the Agriculture Layer below it.")
		#"Trading Post":
			#if _last_placed_piece and (_last_placed_piece.name == "Marketplace Layer" or _last_placed_piece.name == "Workshop Layer"):
				#set_selected_piece_scene(tower_layers[12].scene) # Adjust index as needed
			#else:
				#print("Trading Post requires the Marketplace and Workshop Layers below it.")
		#"Watchtower":
			#if _last_placed_piece and _last_placed_piece.name == "Observation Deck":
				#set_selected_piece_scene(tower_layers[13].scene) # Adjust index as needed
			#else:
				#print("Watchtower requires the Observation Deck below it.")
		#"Water Reservoir":
			#if _last_placed_piece and _last_placed_piece.name == "Agriculture Layer":
				#set_selected_piece_scene(tower_layers[14].scene) # Adjust index as needed
			#else:
				#print("Water Reservoir requires the Agriculture Layer below it.")
		#"Tavern":
			#set_selected_piece_scene(tower_layers[15].scene) # Adjust index as needed
		#"Armory":
			#if _last_placed_piece and _last_placed_piece.name == "Barracks Layer":
				#set_selected_piece_scene(tower_layers[16].scene) # Adjust index as needed
			#else:
				#print("Armory requires the Barracks Layer below it.")
		#"Smithy":
			#if _last_placed_piece and _last_placed_piece.name == "Workshop Layer":
				#set_selected_piece_scene(tower_layers[17].scene) # Adjust index as needed
			#else:
				#print("Smithy requires the Workshop Layer below it.")
		#"Clocktower":
			#if _last_placed_piece and _last_placed_piece.name == "Library Layer":
				#set_selected_piece_scene(tower_layers[18].scene) # Adjust index as needed
			#else:
				#print("Clocktower requires the Library Layer below it.")
		#"Hospital":
			#if _last_placed_piece and (_last_placed_piece.name == "Barracks Layer" and _last_placed_piece.name == "Engineering Layer"):
				#set_selected_piece_scene(tower_layers[19].scene) # Adjust index as needed
			#else:
				#print("Hospital requires the Barracks and Engineering Layers below it.")
		#_:
			#print("Unknown tower part selected.")
			#pass
	#
	place_selected_piece()

func remove_text_after_pipe(original_text: String) -> String:
	var pipe_index = original_text.find("|")
	
	if pipe_index != -1:
		# Remove any space before the |
		if pipe_index > 0 and original_text[pipe_index - 1] == " ":
			return original_text.substr(0, pipe_index - 1)
		else:
			return original_text.substr(0, pipe_index)
	else:
		# Return the original text if | is not found
		return original_text

# Called every frame to check game logic
func _process(delta):
	if _tower_list_tab == null && get_tree().get_first_node_in_group("Towers List Item Tab") != null:
		_tower_list_tab = get_tree().get_first_node_in_group("Towers List Item Tab")
		get_tree().get_first_node_in_group("Towers List Item Tab").connect("item_activated", tower_selected)
		update_item_list_text_with_cost()
	if _night_wave_active:
		check_enemies_defeated()

func _ready():
	pass
