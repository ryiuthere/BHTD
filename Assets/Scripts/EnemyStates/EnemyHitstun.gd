class_name EnemyHitstun
extends EnemyState

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.HITSTUN

func enter() -> void:
	animator.play(Constants.HITSTUN)

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	check_incoming_hitboxes(delta)
	if (stateMachine.hitstop_frames) > 0:
		return Constants.STATE_NAME.HITSTUN
	character.velocity.x *= (1 - Constants.FRICTION * delta * 0.1)
	character.velocity.y += Constants.GRAVITY * delta
	character.move_and_slide()
	var return_to_neutral := stateMachine.hitstun_frames <= 0
	if return_to_neutral:
		if character.is_on_floor():
			return Constants.STATE_NAME.IDLE
		else:
			return Constants.STATE_NAME.AIR
	return Constants.STATE_NAME.HITSTUN

func process(_delta: float) -> Constants.STATE_NAME:
	return Constants.STATE_NAME.HITSTUN
