class_name Idle
extends State

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.IDLE

func enter() -> void:
	# Setting to zero is required to prevent a rare bug where entering and 
	# leaving idle in 1 frame would force a walk, even if it should be a run
	prev_axis = Vector2.ZERO
	curr_axis = Vector2.ZERO
	stateMachine.can_double_jump = true
	animator.play(Constants.IDLE)

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	return ground_physics(delta)

func process(delta: float) -> Constants.STATE_NAME:
	super(delta)
	if (InputBuffer.is_action_press_buffered(Constants.JUMP)):
		return Constants.STATE_NAME.JUMP
	elif is_attack_input():
		return Constants.STATE_NAME.ATTACK
	elif is_down_angle():
		return Constants.STATE_NAME.CROUCH
	elif abs(curr_axis.x) > Constants.FLOAT_DEADZONE:
		if is_run_input(delta):
			return Constants.STATE_NAME.RUN
		else:
			return Constants.STATE_NAME.WALK
	return Constants.STATE_NAME.IDLE
