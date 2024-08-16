extends CanvasLayer


@export_file("*.tscn", "*.scn") var _next_scene
@export var _animation: AnimationPlayer
@export var _animated_control: Control


func _ready() -> void:
	_animated_control.pivot_offset = _animated_control.size / 2
	
	_animation.animation_finished.connect(_on_animation_finished)
	_animation.play("fade_out")
	

func _on_animation_finished(anim_name):
	if anim_name == "fade_out":
		print("animation finished")
		get_tree().change_scene_to_file(_next_scene)
