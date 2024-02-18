class_name Walk
extends State

@export var WALK_FORCE := 5000
@export var MAX_WALK_SPEED := 100

var curr_axis: float

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.WALK

func enter() -> void:
	stateMachine.can_double_jump = true
	curr_axis = Input.get_axis("Left", "Right");
	stateMachine.animator.play("Walk")

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	sprite.flip_h = curr_axis < 0	
	character.velocity.x += WALK_FORCE * delta * curr_axis
	if (abs(character.velocity.x) > MAX_WALK_SPEED):
		character.velocity.x = clamp(character.velocity.x, -MAX_WALK_SPEED, MAX_WALK_SPEED)
	character.move_and_slide()
	if !character.is_on_floor():
		return Constants.STATE_NAME.AIR
	return Constants.STATE_NAME.WALK

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
	elif abs(distx) > Constants.WALK_RUN_SENSITIVITY * delta and abs(next_axis.x) > abs(curr_axis):
		next_state = Constants.STATE_NAME.RUN
	else:
		next_state = Constants.STATE_NAME.WALK
	curr_axis = next_axis.x
	return next_state
