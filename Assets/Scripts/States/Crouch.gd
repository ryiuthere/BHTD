class_name Crouch
extends State

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.CROUCH

func enter() -> void:
	prev_axis = Vector2.ZERO
	curr_axis = Vector2.ZERO
	stateMachine.can_double_jump = true
	stateMachine.animator.play(Constants.CROUCH)

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	check_sprite_direction()
	return ground_physics(delta)

func process(delta: float) -> Constants.STATE_NAME:
	super(delta)
	if (InputBuffer.is_action_press_buffered(Constants.JUMP)):
		return Constants.STATE_NAME.JUMP
	elif is_attack_input():
		return Constants.STATE_NAME.ATTACK
	if curr_axis == Vector2.ZERO:
		return Constants.STATE_NAME.IDLE
	elif !is_down_angle():
		if is_run_input(delta):
			return Constants.STATE_NAME.RUN
		else:
			return Constants.STATE_NAME.WALK
	return Constants.STATE_NAME.CROUCH
