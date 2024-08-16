extends Node3D

@export var towerStats:towerFunction
@export var towerFullyBuilt:bool = false
@export var towerBuildTime:float = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	$BuildTimer.connect("timout", buildFinished)
	$BuildTimer.start(towerBuildTime)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if towerFullyBuilt:
		towerStats.doTowerStuff(delta)

func buildFinished():
	towerFullyBuilt = true
