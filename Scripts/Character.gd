extends CharacterBody2D


@export var speed = 175
@export var start_acceleration = 24
@export var end_acceleration = 48

@export var jump_velocity = -300.0
@export var max_jump_height = -100.0

@export var max_jumps = 1
var current_jump = 0

var coyoteJump = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity_jump = 1000
var gravity_fall = 1800
var gravity_max = 1000

var right;
var left;
var up;
var pressing_up;
var down;

func _physics_process(delta):
	up = Input.is_action_just_pressed("up")
	pressing_up = Input.is_action_pressed("up")

	down = Input.is_action_just_pressed("down")
	left = Input.is_action_just_pressed("left")
	right = Input.is_action_just_pressed("up")

	apply_gravity(delta)

	handle_jump()
	handle_movement()
	handle_flip_x()
	handle_animation()
	move_and_slide()
	set_labels();


# Add the gravity.
func apply_gravity(delta):
	if not is_on_floor():
		if velocity.y > 0 || not pressing_up:
			velocity.y += gravity_fall * delta
		else:
			velocity.y += gravity_jump * delta


func handle_jump():
	if is_on_floor():
		current_jump = 0
	if up and current_jump < max_jumps:
		current_jump += 1
		velocity.y = jump_velocity


func handle_flip_x():
	if velocity.x > 0:
		$Plumber.flip_h = false
	elif velocity.x < 0:
		$Plumber.flip_h = true


# Get the input direction and handle the movement/deceleration.
# As good practice, you should replace UI actions with custom gameplay actions.
func handle_movement():
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		if direction.x > 0:
			velocity.x = min(velocity.x + start_acceleration, direction.x * speed)
		if direction.x < 0:
			velocity.x = max(velocity.x - start_acceleration, direction.x * speed)
	else:
		if velocity.x > 0:
			velocity.x = max(int(velocity.x) - end_acceleration, 0)
		elif velocity.x < 0:
			velocity.x = min(int(velocity.x) + end_acceleration, 0)


func handle_animation():
	var direction = Input.get_vector("left", "right", "up", "down")
	if not is_on_floor():
		$Plumber/AnimationTree.set("parameters/state/transition_request", "jump")
	else:
		if velocity.x == 0:
			$Plumber/AnimationTree.set("parameters/state/transition_request", "idle")
		else:
			$Plumber/AnimationTree.set("parameters/state/transition_request", "walk")

func set_labels():
	var direction = Input.get_vector("left", "right", "up", "down")
	$debug.set("text", velocity.x)

func is_positive(value):
	return value >= 0
