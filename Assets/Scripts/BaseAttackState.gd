class_name BaseAttackState
extends BaseState

func get_state() -> Constants.ATTACK_STATE_NAME:
	return Constants.ATTACK_STATE_NAME.NONE

func setup(stateHandler: StateMachine) -> void:
	stateMachine = stateHandler as StateMachine
	character = stateMachine.character
	animator = stateMachine.animator
	sprite = stateMachine.sprite

func enter() -> void:
	# Start animating, etc.
	animator.play(Constants.ATTACK_STATE_NAME.keys()[get_state()])
	pass
	
func exit() -> void:
	# Clean up
	pass

func process_attack(_delta: float) -> Constants.ATTACK_STATE_NAME:
	# Handle input
	get_axis()
	if !animator.is_playing() or animator.current_animation != Constants.ATTACK_STATE_NAME.keys()[get_state()]:
		return Constants.ATTACK_STATE_NAME.NONE
	else:
		return get_state()
