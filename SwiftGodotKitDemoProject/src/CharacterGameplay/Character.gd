extends CharacterBody3D
# Modified version of default CharacterBody3D template script

@onready var HEAD = $Head

const SENSITIVITY = 0.05
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _input(event):
	if event is InputEventScreenDrag:
		rotate_y(deg_to_rad(-event.relative.x * SENSITIVITY))
		HEAD.rotate_x(deg_to_rad(-event.relative.y * SENSITIVITY))

		HEAD.rotation.x = clamp(HEAD.rotation.x, deg_to_rad(-80), deg_to_rad(60))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()