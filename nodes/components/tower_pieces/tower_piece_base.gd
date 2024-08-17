extends Node3D
class_name tower_piece_node

@export_group("Tower Stats")
@export var towerStats: tower_function
@export var towerFullyBuilt: bool = false
@export var towerBuildTime: float = 5

@export_group("Compatible Tower Base")
@export var compatible_tower_base_name: String

@export_dir var yesnt: String = "res://nodes/components/tower_pieces_finished/merchant_outpost/merchant_outpost.tscn"



func _ready():
	$BuildTimer.connect("timeout", buildFinished)
	if not towerFullyBuilt:
		$BuildTimer.start(towerBuildTime)

# Call this function every night to do the tower stuff such as taking money and giving materials
func do_nightly_tasks():
	if towerFullyBuilt:
		towerStats.doTowerStuff()

# Function to check if a new piece can be placed on this piece
func can_place_piece(new_piece: Node3D) -> bool:
	return true


# Function to check if the new piece is compatible with the current piece
func is_compatible(new_piece: Node3D) -> bool:
	# Check compatibility based on the group name
	if not compatible_tower_base_name == "":
		if not new_piece.is_in_group(compatible_tower_base_name):
			print("New piece does not belong to the required compatibility group.")
			return false
	
	# Additional compatibility checks can be added here
	# For example, you could compare levels or stats if needed

	return true

func buildFinished():
	towerFullyBuilt = true

# Function to instantiate and place the new tower piece
func instantiate_tower_piece(scene: PackedScene) -> bool:
	if scene:
		var new_piece = scene.instantiate()
		if new_piece and new_piece is Node3D:
			if can_place_piece(new_piece):
				# Add the new piece to the scene
				$ConnectionPoint.add_child(new_piece)
				print("New piece instantiated and placed.")
				return true
			else:
				print("New piece cannot be placed.")
		else:
			print("Failed to instantiate the new piece.")
	else:
		print("No scene provided to instantiate.")
	
	return false
