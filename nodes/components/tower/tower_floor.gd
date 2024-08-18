class_name TowerFloor
extends Node3D

## This script defines Placed Tower Floor


@export var part_level: int = 1
@export var defense_level: int = 1

@export var tower_layer_resource: TowerLayerResource
# Timervar packed_scene: PackedScene = load(tower_layer_resource.scene_path)
# Other info

# You have a tower build timer, so you need this
var _floor_fully_built: bool = false

@onready var connection_point: Node3D = $ConnectionPoint
@onready var _build_timer: Timer = $BuildTimer



func _ready():
	_build_timer.connect("timeout", _on_build_finished)
	if not _floor_fully_built:
		_build_timer.start(tower_layer_resource.build_time)
		

func _on_build_finished():
	_floor_fully_built = true
	#! Add some visuals


# Call this function every night to do the tower stuff such as taking money and giving materials
func do_nightly_tasks():
	#! WIP
	if _floor_fully_built:
		pass
		

func get_tower_top_position() -> Vector3:
	return connection_point.global_position
	
