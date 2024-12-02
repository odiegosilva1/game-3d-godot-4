extends CharacterBody3D

const SPEED = 2000.0
const JUMP_VELOCITY = 15.0

@export var view : Node3D
var gravity = 0
var movement_velocity : Vector3
var rotation_direction : float



func _physics_process(delta):
	handle_input(delta)
	apply_gravity(delta)
	jump(delta)
	
	var applied_velocity : Vector3
	applied_velocity = velocity.lerp(movement_velocity, delta * 10)
	applied_velocity.y = -gravity
	
	velocity = applied_velocity
	# Add the gravity.dw
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		
		
	move_and_slide()
	
func handle_input(delta):
	var input := Vector3.ZERO
	input.x = Input.get_axis("move_left","move_right")
	input.z = Input.get_axis("move_forward","move_backward")
	
	input = input.rotated(Vector3.UP, view.rotation.y).normalized()
	velocity = input * SPEED * delta
	
	
func handle_animation():
	pass

func apply_gravity(delta):
	if not is_on_floor():
		gravity += 25 * delta 
	
func jump(_delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		gravity = -JUMP_VELOCITY
		
	if gravity > 0 and is_on_floor():
		gravity = 0 
		
