class_name AL5
extends AirAttackState

func get_attack_state() -> Constants.ATTACK_STATE_NAME:
	return Constants.ATTACK_STATE_NAME.AL5

func cancel_attack_states() -> Array:
	return [
		Constants.ATTACK_STATE_NAME.AL5
		]
