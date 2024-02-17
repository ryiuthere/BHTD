class_name Run
extends State

@export var RUN_FORCE := 5000
@export var MAX_RUN_SPEED := 1000

var curr_axis: float

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.RUN

func enter() -> void:
	curr_axis = Input.get_axis("Left", "Right");
	stateMachine.animator.play("Run")

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	sprite.flip_h = curr_axis < 0
	character.velocity.x += RUN_FORCE * delta * curr_axis
	if (abs(character.velocity.x) > MAX_RUN_SPEED):
		character.velocity.x = clamp(character.velocity.x, -MAX_RUN_SPEED, MAX_RUN_SPEED)
	super(delta)
	return Constants.STATE_NAME.RUN

func process(delta: float) -> Constants.STATE_NAME:
	var next_axis = Input.get_axis("Left", "Right")
	var dist = next_axis - curr_axis
	var next_state
	if next_axis == 0:
		next_state = Constants.STATE_NAME.IDLE
	elif dist < Constants.RUN_WALK_SENSITIVITY * delta and abs(curr_axis) < 0.5:
		next_state = Constants.STATE_NAME.WALK
	else:
		next_state = Constants.STATE_NAME.RUN
	curr_axis = next_axis
	return next_state
