class_name Idle
extends State

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.IDLE

func enter() -> void:
	animator.play("Idle")

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	character.velocity.x *= (1 - Constants.FRICTION * delta)
	character.move_and_slide()
	if !character.is_on_floor():
		return Constants.STATE_NAME.AIR
	return Constants.STATE_NAME.IDLE

func process(delta: float) -> Constants.STATE_NAME:
	if (Input.is_action_just_pressed("Jump")):
		return Constants.STATE_NAME.JUMP
	var axis := Input.get_vector("Left", "Right", "Up", "Down")
	var angle = axis.angle()
	if axis.y > 0 and angle > PI / 4 and angle < 3 * PI / 4:
		return Constants.STATE_NAME.CROUCH
	if abs(axis.x) > 0:
		if abs(axis.x) > Constants.WALK_RUN_SENSITIVITY * delta:
			return Constants.STATE_NAME.RUN
		else:
			return Constants.STATE_NAME.WALK
	return Constants.STATE_NAME.IDLE
