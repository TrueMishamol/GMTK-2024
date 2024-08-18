extends Node3D


@onready var sky: Node3D = $Enviroment/Sky


# Wave state variable
var _night_wave_active: bool = false


func _ready() -> void:
	sky.day_time = GameInfo.globals.day_time
	sky.day_of_year = GameInfo.globals.day_of_year
	GameInfo.globals.set_sky(sky)



func _process(_delta):
	if _night_wave_active:
		_check_enemies_defeated()



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
