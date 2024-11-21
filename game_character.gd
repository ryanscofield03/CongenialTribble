extends Node3D

@export var pickup_anim_running: bool = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print(anim_name)
	print("HERE")
	
	if anim_name == "pickup":
		pickup_anim_running = false
