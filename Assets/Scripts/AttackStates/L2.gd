class_name L2
extends GroundAttackState

func get_state() -> Constants.ATTACK_STATE_NAME:
	return Constants.ATTACK_STATE_NAME.L2

func enter() -> void:
	animator.play("L2")
