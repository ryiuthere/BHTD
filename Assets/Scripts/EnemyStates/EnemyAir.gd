class_name EnemyAir
extends EnemyState

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.AIR

func enter() -> void:
	stateMachine.animator.play(Constants.AIR)

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	apply_horizontal_movement(delta, stateMachine.AIR_MOVE_FORCE, stateMachine.MAX_AIR_SPEED)
	return air_physics(delta)

func process(_delta: float) -> Constants.STATE_NAME:
	return Constants.STATE_NAME.AIR
