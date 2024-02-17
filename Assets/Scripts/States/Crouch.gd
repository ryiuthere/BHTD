class_name Crouch
extends State

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.CROUCH

func enter() -> void:
	stateMachine.animator.play("Crouch")

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	character.velocity.x *= (1 - Constants.FRICTION * delta * 0.25)
	character.move_and_slide()
	return Constants.STATE_NAME.CROUCH

func process(delta: float) -> Constants.STATE_NAME:
	if (Input.is_action_just_pressed("Jump")):
		return Constants.STATE_NAME.AIRBORNE
	var axis := Input.get_vector("Left", "Right", "Up", "Down")
	var angle = axis.angle()
	if axis.y <= 0 or angle < PI / 4 or angle > 3 * PI / 4:
		if abs(axis.x) > Constants.WALK_RUN_SENSITIVITY * delta:
			return Constants.STATE_NAME.RUN
		else:
			return Constants.STATE_NAME.WALK
	return Constants.STATE_NAME.CROUCH
