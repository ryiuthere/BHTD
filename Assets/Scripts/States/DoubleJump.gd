class_name DoubleJump
extends State


func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.DOUBLEJUMP

func enter() -> void:
	stateMachine.can_double_jump = false
	character.velocity.y = -stateMachine.INITIAL_DOUBLEJUMP_FORCE
	stateMachine.animator.play(Constants.DOUBLEJUMP)

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	if (character.velocity.y >= 0):
		return Constants.STATE_NAME.AIR
	apply_horizontal_movement(delta, stateMachine.AIR_MOVE_FORCE, stateMachine.MAX_AIR_SPEED)
	return air_physics(delta)

func process(delta: float) -> Constants.STATE_NAME:
	super(delta)
	if check_air_attack_input():
		return Constants.STATE_NAME.AIRATTACK
	return get_state()
