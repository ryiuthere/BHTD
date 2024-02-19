class_name Crouch
extends State

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.CROUCH

func enter() -> void:
	stateMachine.can_double_jump = true
	stateMachine.animator.play("Crouch")

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	if (abs(curr_axis.x) > Constants.FLOAT_DEADZONE):
		sprite.flip_h = curr_axis.x < 0
	return ground_physics(delta)

func process(delta: float) -> Constants.STATE_NAME:
	super(delta)
	if (InputBuffer.is_action_press_buffered("Jump")):
		return Constants.STATE_NAME.JUMP
	if curr_axis == Vector2.ZERO:
		return Constants.STATE_NAME.IDLE
	elif !is_crouch_angle():
		if is_run_input(delta):
			return Constants.STATE_NAME.RUN
		else:
			return Constants.STATE_NAME.WALK
	return Constants.STATE_NAME.CROUCH
