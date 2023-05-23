extends CharacterBody2D


@export var speed = 175
@export var start_acceleration = 24
@export var end_acceleration = 48

@export var jump_velocity = -350.0
@export var max_jump_height = -100.0

@export var max_jumps = 1
var current_jump = 0

var coyoteJump = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity_jump = 1000
var gravity_fall = 1800
var gravity_max = 1000

var right;
var pressing_right;
var left;
var pressing_left;
var up;
var pressing_up;
var down;

var isDead = false;
var dir = 0;

func _ready():
	add_to_group("Characters")
	
func _physics_process(delta):
	up = Input.is_action_just_pressed("up")
	pressing_up = Input.is_action_pressed("up")

	down = Input.is_action_just_pressed("down")
	left = Input.is_action_just_pressed("left")
	pressing_left = Input.is_action_pressed("left")
	right = Input.is_action_just_pressed("right")
	pressing_right = Input.is_action_pressed("right")
	dir = int(pressing_right) - int(pressing_left)
	apply_gravity(delta)
	if not isDead:
		handle_jump()
		handle_movement()
		handle_flip_x()
		handle_animation()
	set_labels();
	move_and_slide()
	handle_out_of_range()


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
#	var direction = Input.get_vector("left", "right", "up", "down")
	if dir:
		if dir > 0:
			velocity.x = min(velocity.x + start_acceleration, dir * speed)
		if dir < 0:
			velocity.x = max(velocity.x - start_acceleration, dir * speed)
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
	$debug.set("text", position.y > 650)

func is_positive(value):
	return value >= 0

func handle_out_of_range():
	if position.y > 800:
		queue_free()

func kill():
	velocity.y = -500
	velocity.x = 0
	$Plumber/AnimationTree.set("parameters/state/transition_request", "die")
	$CollisionShape2D.set_deferred("disabled", true)
	$Plumber.set_scale(Vector2(1, -1))
	isDead = true
