class_name GroundAttackState
extends BaseState

func get_state() -> Constants.ATTACK_STATE_NAME:
	return Constants.ATTACK_STATE_NAME.L5

func setup(stateHandler: StateMachine) -> void:
	stateMachine = stateHandler as StateMachine
	character = stateMachine.character
	animator = stateMachine.animator
	sprite = stateMachine.sprite

func enter() -> void:
	# Start animating, etc.
	pass
	
func exit() -> void:
	# Clean up
	pass

func physics_process(_delta: float) -> void:
	# Handle physics
	pass

func process_attack(_delta: float) -> Constants.ATTACK_STATE_NAME:
	# Handle input
	if stateMachine.attack_status == Constants.ATTACK_STATUS.NONE:
		return Constants.ATTACK_STATE_NAME.NONE
	else:
		return get_state()
