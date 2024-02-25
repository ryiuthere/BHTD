class_name GroundAttackState
extends BaseAttackState

func get_state() -> Constants.ATTACK_STATE_NAME:
	return Constants.ATTACK_STATE_NAME.L5

func physics_process(delta: float) -> Constants.STATE_NAME:
	# Handle physics
	return ground_physics(delta)

func ground_physics(delta: float, apply_friction := true) -> Constants.STATE_NAME:
	if check_incoming_hitboxes():
		return Constants.STATE_NAME.HITSTUN
	if stateMachine.hitstop_frames <= 0:
		if apply_friction:
			character.velocity.x *= (1 - Constants.FRICTION * delta)
		character.move_and_slide()
		if !character.is_on_floor():
			return Constants.STATE_NAME.AIR
	return Constants.STATE_NAME.ATTACK
