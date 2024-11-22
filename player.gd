extends CharacterBody3D


const SPEED = 5.0
const ROTATION_SPEED = 5.0

@onready var animation_player: AnimationPlayer = $PlayerCollision/PlayerMesh/AnimationPlayer
var current_animation: String = "Idle"

var last_direction: Vector3 = Vector3.DOWN

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")	
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		last_direction = direction
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	if velocity.length() > 0.1:
		#var facing_direction = velocity.normalized()
		#var facing_angle = atan2(facing_direction.x, facing_direction.z)
		#$RayCastPickup.rotation = Vector3(0, facing_angle, 0)	
		current_animation = "Walk"
	else:
		current_animation = "Idle"
		
	if Input.is_action_just_pressed("pickup") && $PlayerCollision/PlayerMesh/RayCastPickup.is_colliding():
		current_animation = "Pickup"
		handle_pickup()
	
	$PlayerCollision/PlayerMesh.rotation.y = lerp_angle($PlayerCollision/PlayerMesh.rotation.y, atan2(last_direction.x, last_direction.z), delta * ROTATION_SPEED)
	handle_animation()
	
func handle_animation():	
	if $PlayerCollision/PlayerMesh.pickup_anim_running == false:	
		if current_animation == "Walk":
			animation_player.play("Walk")
		elif current_animation == "Idle":
			animation_player.play("Idle")
		elif current_animation == "Pickup":
			animation_player.play("Pickup")
			$PlayerCollision/PlayerMesh.pickup_anim_running = true
			
func handle_pickup():
	print("pickup")
