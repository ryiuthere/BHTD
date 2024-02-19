class_name Attack
extends State

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.IDLE

func enter() -> void:
	pass

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	return ground_physics(delta)

func process(delta: float) -> Constants.STATE_NAME:
	return super(delta)
