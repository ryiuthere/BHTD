class_name Run
extends State

@export var RUN_FORCE := 7000
@export var MAX_RUN_SPEED := 300

var curr_axis: float

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.RUN

func enter() -> void:
	stateMachine.can_double_jump = true
	curr_axis = Input.get_axis("Left", "Right");
	stateMachine.animator.play("Run")

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	sprite.flip_h = curr_axis < 0
	character.velocity.x += RUN_FORCE * delta * curr_axis
	if (abs(character.velocity.x) > MAX_RUN_SPEED):
		character.velocity.x = clamp(character.velocity.x, -MAX_RUN_SPEED, MAX_RUN_SPEED)
	character.move_and_slide()
	if !character.is_on_floor():
		return Constants.STATE_NAME.AIR
	return Constants.STATE_NAME.RUN

func process(delta: float) -> Constants.STATE_NAME:
	var next_axis := Input.get_vector("Left", "Right", "Up", "Down")
	var angle = next_axis.angle()
	var distx = next_axis.x - curr_axis
	var next_state
	if (InputBuffer.is_action_press_buffered("Jump")):
		next_state = Constants.STATE_NAME.JUMP
	elif next_axis.y > 0 and angle > Constants.CROUCH_ANGLE_MIN and angle < Constants.CROUCH_ANGLE_MAX:
		next_state = Constants.STATE_NAME.CROUCH
	elif next_axis.x == 0:
		next_state = Constants.STATE_NAME.IDLE
	elif distx < Constants.RUN_WALK_SENSITIVITY * delta and abs(curr_axis) < 0.5:
		next_state = Constants.STATE_NAME.WALK
	else:
		next_state = Constants.STATE_NAME.RUN
	curr_axis = next_axis.x
	return next_state
