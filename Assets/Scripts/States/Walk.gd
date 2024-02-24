class_name Walk
extends State

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.WALK

func enter() -> void:
	stateMachine.can_double_jump = true
	stateMachine.animator.play(Constants.WALK)

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	check_sprite_direction()
	apply_horizontal_movement(delta, stateMachine.WALK_FORCE, stateMachine.MAX_WALK_SPEED)
	return ground_physics(delta, false)

func process(delta: float) -> Constants.STATE_NAME:
	super(delta)
	if (InputBuffer.is_action_press_buffered(Constants.JUMP)):
		return Constants.STATE_NAME.JUMP
	elif check_ground_attack_input():
		return Constants.STATE_NAME.ATTACK
	elif is_down_angle():
		return Constants.STATE_NAME.CROUCH
	elif curr_axis.x == 0:
		return Constants.STATE_NAME.IDLE
	elif is_run_input(delta):
		return Constants.STATE_NAME.RUN
	else:
		return Constants.STATE_NAME.WALK
