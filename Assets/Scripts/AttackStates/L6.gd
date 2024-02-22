class_name L6
extends GroundAttackState

func get_state() -> Constants.ATTACK_STATE_NAME:
	return Constants.ATTACK_STATE_NAME.L6

func enter() -> void:
	animator.play("L6")
