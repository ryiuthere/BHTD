class_name BaseAttackState
extends BaseState

func get_attack_state() -> Constants.ATTACK_STATE_NAME:
	return Constants.ATTACK_STATE_NAME.NONE

func setup(stateHandler: StateMachine) -> void:
	stateMachine = stateHandler as StateMachine
	character = stateMachine.character
	animator = stateMachine.animator
	sprite = stateMachine.sprite

func enter() -> void:
	# Start animating, etc.
	animator.play(Constants.ATTACK_STATE_NAME.keys()[get_attack_state()], 0)
	animator.seek(0, true) # Restart animation if cancelling into same move
	pass

func process_attack(_delta: float) -> Constants.ATTACK_STATE_NAME:
	# Handle input
	get_axis()
	if !animator.is_playing() or animator.current_animation != Constants.ATTACK_STATE_NAME.keys()[get_attack_state()]:
		return Constants.ATTACK_STATE_NAME.NONE
	else:
		return Constants.ATTACK_STATE_NAME.CONTINUE

func cancel_attack_states() -> Array:
	return []
