extends Control
class_name SceneLoader_MenuContainer


@export var animation: AnimationPlayer

signal on_animation_finished


func _ready() -> void:
	animation.animation_finished.connect(_on_animation_finished)


func fade_in():
	animation.play("fade_in")
	
	
func fade_out():
	animation.play("fade_out")
	
	
func _on_animation_finished(anim_name):
	if anim_name == "fade_in" || "fade_out":
		on_animation_finished.emit()
