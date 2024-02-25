class_name AirAttackState
extends BaseAttackState

var fast_fall: bool

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.AIRATTACK

func get_attack_state() -> Constants.ATTACK_STATE_NAME:
	return Constants.ATTACK_STATE_NAME.AL5

func enter() -> void:
	super()
	fast_fall = false

func physics_process(delta: float) -> Constants.STATE_NAME:
	# Handle physics
	apply_horizontal_movement(delta, stateMachine.AIR_MOVE_FORCE, stateMachine.MAX_AIR_SPEED)
	if fast_fall:
		character.velocity.y = stateMachine.MAX_FALL_SPEED + 150
	return air_physics(delta)

func air_physics(delta: float, apply_friction := true) -> Constants.STATE_NAME:
	var next_state := super(delta, apply_friction)
	if next_state != get_state():
		return next_state
	if stateMachine.hitstop_frames <= 0:
		if (!fast_fall and character.velocity.y >= 0
			and InputBuffer.is_action_press_buffered(Constants.DOWN)):
			fast_fall = true
	return get_state()
