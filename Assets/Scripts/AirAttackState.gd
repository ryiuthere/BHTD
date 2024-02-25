class_name AirAttackState
extends BaseAttackState

var fast_fall: bool

func get_state() -> Constants.ATTACK_STATE_NAME:
	return Constants.ATTACK_STATE_NAME.AL5

func enter() -> void:
	super()
	fast_fall = false

func physics_process(delta: float) -> Constants.STATE_NAME:
	# Handle physics
	apply_horizontal_movement(delta, stateMachine.AIR_MOVE_FORCE, stateMachine.MAX_AIR_SPEED)
	if fast_fall:
		character.velocity.y = stateMachine.MAX_FALL_SPEED + 150
	return air_physics(delta)

func air_physics(delta: float, apply_friction := true) -> Constants.STATE_NAME:
	if check_incoming_hitboxes():
		return Constants.STATE_NAME.HITSTUN
	if stateMachine.hitstop_frames <= 0:
		if apply_friction:
			character.velocity.x *= (1 - Constants.FRICTION * delta * 0.1)
		character.velocity.y += Constants.GRAVITY * delta
		character.move_and_slide()
		if (character.is_on_floor()):
			if curr_axis.x != 0:
				return Constants.STATE_NAME.RUN
			else:
				return Constants.STATE_NAME.IDLE
		if (!fast_fall and character.velocity.y >= 0
			and InputBuffer.is_action_press_buffered(Constants.DOWN)):
			fast_fall = true
	return Constants.STATE_NAME.AIRATTACK
