class_name Walk
extends State

@export var WALK_FORCE := 5000
@export var MAX_WALK_SPEED := 500

var curr_axis: float

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.WALK

func enter() -> void:
	curr_axis = Input.get_axis("Left", "Right");
	stateMachine.animator.play("Walk")

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	sprite.flip_h = curr_axis < 0
	character.velocity.x += WALK_FORCE * delta * curr_axis
	if (abs(character.velocity.x) > MAX_WALK_SPEED):
		character.velocity.x = clamp(character.velocity.x, -MAX_WALK_SPEED, MAX_WALK_SPEED)
	super(delta)
	return Constants.STATE_NAME.WALK

func process(delta: float) -> Constants.STATE_NAME:
	var next_axis = Input.get_axis("Left", "Right")
	var dist = next_axis - curr_axis
	var next_state
	if next_axis == 0:
		next_state = Constants.STATE_NAME.IDLE
	elif dist > Constants.WALK_RUN_SENSITIVITY * delta and abs(next_axis) > abs(curr_axis):
		next_state = Constants.STATE_NAME.RUN
	else:
		next_state = Constants.STATE_NAME.WALK
	curr_axis = next_axis
	return next_state
