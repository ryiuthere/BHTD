class_name Run
extends State



func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.RUN

func enter() -> void:
	stateMachine.can_double_jump = true
	stateMachine.animator.play(Constants.RUN)

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	check_sprite_direction()
	apply_horizontal_movement(delta, stateMachine.RUN_FORCE, stateMachine.MAX_RUN_SPEED)
	return ground_physics(delta, false)

func process(delta: float) -> Constants.STATE_NAME:
	super(delta)
	var distx = curr_axis.x - prev_axis.x
	if (InputBuffer.is_action_press_buffered(Constants.JUMP)):
		return Constants.STATE_NAME.JUMP
	elif check_ground_attack_input():
		return Constants.STATE_NAME.ATTACK
	elif is_down_angle():
		return Constants.STATE_NAME.CROUCH
	elif curr_axis.x == 0:
		return Constants.STATE_NAME.IDLE
	elif distx < Constants.RUN_WALK_SENSITIVITY * delta and abs(curr_axis.x) < 0.5:
		return Constants.STATE_NAME.WALK
	else:
		return Constants.STATE_NAME.RUN
