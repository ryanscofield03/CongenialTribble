extends Node3D

@export var pickup_anim_running: bool = false

func _ready() -> void:
	$AnimationPlayer.animation_finished.connect(_handle_animation_finished)

func _handle_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Pickup":
		pickup_anim_running = false
