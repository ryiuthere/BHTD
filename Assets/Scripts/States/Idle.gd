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
	super(delta)
	return Constants.STATE_NAME.IDLE

func process(delta: float) -> Constants.STATE_NAME:
	var axis = abs(Input.get_axis("Left", "Right"))
	if axis > 0:
		if axis > Constants.WALK_RUN_SENSITIVITY * delta:
			return Constants.STATE_NAME.RUN
		else:
			return Constants.STATE_NAME.WALK
	return Constants.STATE_NAME.IDLE
