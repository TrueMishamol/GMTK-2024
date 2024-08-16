extends Area3D

@export var spirit_scene: PackedScene


#func _physics_process(delta):
	#var objects = get_overlapping_bodies()
	#if objects.has() == true:

func _on_body_entered(body):
	_spawn(body)

func _spawn(body: Node3D):
	#var spirit = spirit_scene.instantiate() #! WIP
	spirit_scene.instantiate() #! WIP
	body.queue_free()


