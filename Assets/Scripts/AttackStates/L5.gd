class_name L5
extends GroundAttackState

func get_state() -> Constants.ATTACK_STATE_NAME:
	return Constants.ATTACK_STATE_NAME.L5

func enter() -> void:
	animator.play("L5")
