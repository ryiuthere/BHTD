class_name EnemyIdle
extends EnemyState

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.IDLE

func enter() -> void:
	animator.play(Constants.IDLE)

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	return ground_physics(delta)

func process(_delta: float) -> Constants.STATE_NAME:
	return Constants.STATE_NAME.IDLE
