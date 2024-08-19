class_name MusicPlayer
extends Node


var _volume

static var audio_stream_player: AudioStreamPlayer


func _ready() -> void:
	audio_stream_player = $AudioStreamPlayer
	
	audio_stream_player.volume_db = UserPreferences.load_or_create().music_audio_level
