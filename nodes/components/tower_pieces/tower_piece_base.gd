extends Node3D
class_name TowerPieceNode

@export_group("Tower Stats")
@export var tower_stats: TowerFunction
@export var tower_fully_built: bool = false
@export var tower_build_time: float = 5

@export_group("Compatible Tower Base")
@export var compatible_tower_base_name: String

func _ready():
	$BuildTimer.connect("timeout", buildFinished)
	if not tower_fully_built:
		$BuildTimer.start(tower_build_time)

# Call this function every night to do the tower stuff such as taking money and giving materials
func do_nightly_tasks():
	if tower_fully_built:
		tower_stats.do_tower_stuff()

func buildFinished():
	tower_fully_built = true

# Function to instantiate and place the new tower piece
func instantiate_tower_piece(scene: PackedScene) -> bool:
	if scene:
		var new_piece = scene.instantiate()
		if new_piece and new_piece is Node3D:
			# Add the new piece to the scene
			$ConnectionPoint.add_child(new_piece)
			print("New piece instantiated and placed.")
			return true
		else:
			print("Failed to instantiate the new piece.")
	else:
		print("No scene provided to instantiate.")
	
	return false
