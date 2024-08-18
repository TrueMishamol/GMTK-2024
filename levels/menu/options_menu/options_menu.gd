extends MarginContainer


# General
@onready var _skip_boot_screen: CheckButton = %SkipBootScreen

# Sound
@onready var _master_slider: HSlider = %MasterSlider
@onready var _music_slider: HSlider = %MusicSlider
@onready var _sfx_slider: HSlider = %SFXSlider


# All the other
@onready var _save_button: Button = %SaveAndReturn

var _user_preferences: UserPreferences


func _ready() -> void:
	_user_preferences = UserPreferences.load_or_create()
	if !_user_preferences: 
		printerr ("Options Menu, _user_preferences == null")
		return
		
	_save_button.pressed.connect(_save_and_return)
	
	# General
	if _skip_boot_screen:
		_skip_boot_screen.button_pressed = _user_preferences.skip_boot_screen
		_skip_boot_screen.toggled.connect(_on_skip_boot_screen_pressed)
	
	
	# Sound
	if _master_slider:
		_master_slider.value = _user_preferences.master_audio_level
		_master_slider.value_changed.connect(_on_master_slider_value_changed)
	if _sfx_slider:
		_sfx_slider.value = _user_preferences.sfx_audio_level
		_sfx_slider.value_changed.connect(_on_sfx_slider_value_changed)
	if _music_slider:
		_music_slider.value = _user_preferences.music_audio_level
		_music_slider.value_changed.connect(_on_music_slider_value_changed)


func _on_skip_boot_screen_pressed(toggled_on):
	_user_preferences.skip_boot_screen = toggled_on


func _on_master_slider_value_changed(value):
	_user_preferences.master_audio_level = value


func _on_sfx_slider_value_changed(value):
	_user_preferences.sfx_audio_level = value
	
	
func _on_music_slider_value_changed(value):
	_user_preferences.music_audio_level = value
	

func _save_and_return():
	_user_preferences.save()
	SceneLoader.load_previous_menu()
