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
	animator.play("Idle")

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	var next_state = ground_physics(delta)
	return Constants.STATE_NAME.IDLE

func process(delta: float) -> Constants.STATE_NAME:
	super(delta)
	if (InputBuffer.is_action_press_buffered("Jump")):
		return Constants.STATE_NAME.JUMP
	var angle = curr_axis.angle()
	if is_crouch_angle():
		return Constants.STATE_NAME.CROUCH
	if abs(curr_axis.x) > Constants.FLOAT_DEADZONE:
		if is_run_input(delta):
			return Constants.STATE_NAME.RUN
		else:
			return Constants.STATE_NAME.WALK
	return Constants.STATE_NAME.IDLE
