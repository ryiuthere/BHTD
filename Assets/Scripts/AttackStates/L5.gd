class_name L5
extends GroundAttackState

func get_attack_state() -> Constants.ATTACK_STATE_NAME:
	return Constants.ATTACK_STATE_NAME.L5

func cancel_attack_states() -> Array:
	return [
		Constants.ATTACK_STATE_NAME.L5,
		Constants.ATTACK_STATE_NAME.L2,
		Constants.ATTACK_STATE_NAME.L6,
		Constants.ATTACK_STATE_NAME.JUMP
		]
