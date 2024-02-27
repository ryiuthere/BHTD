class_name GroundAttackState
extends BaseAttackState

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.ATTACK

func get_attack_state() -> Constants.ATTACK_STATE_NAME:
	return Constants.ATTACK_STATE_NAME.L5

func physics_process(delta: float) -> Constants.STATE_NAME:
	# Handle physics
	return ground_physics(delta)

func process_attack(delta: float) -> Constants.ATTACK_STATE_NAME:
	var next_state = super(delta)
	if next_state == Constants.ATTACK_STATE_NAME.CONTINUE:
		var inputted_state := get_ground_attack_from_input()
		if cancel_attack_states().has(inputted_state):
			next_state = inputted_state
	return next_state
