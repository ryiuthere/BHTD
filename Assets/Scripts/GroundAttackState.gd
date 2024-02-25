class_name GroundAttackState
extends BaseAttackState

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.ATTACK

func get_attack_state() -> Constants.ATTACK_STATE_NAME:
	return Constants.ATTACK_STATE_NAME.L5

func physics_process(delta: float) -> Constants.STATE_NAME:
	# Handle physics
	return ground_physics(delta)
