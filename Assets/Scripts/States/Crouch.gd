class_name Crouch
extends State

var curr_axisx: float = 0

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.CROUCH

func enter() -> void:
	stateMachine.animator.play("Crouch")

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	if (abs(curr_axisx) < Constants.FLOAT_DEADZONE):
		sprite.flip_h = curr_axisx < 0
	character.velocity.x *= (1 - Constants.FRICTION * delta * 0.25)
	character.move_and_slide()
	if !character.is_on_floor():
		return Constants.STATE_NAME.AIR
	return Constants.STATE_NAME.CROUCH

func process(delta: float) -> Constants.STATE_NAME:
	if (Input.is_action_just_pressed("Jump")):
		return Constants.STATE_NAME.JUMP
	var axis := Input.get_vector("Left", "Right", "Up", "Down")
	var angle = axis.angle()
	if axis == Vector2.ZERO:
		return Constants.STATE_NAME.IDLE
	elif axis.y <= 0 or angle <= PI / 4 or angle >= 3 * PI / 4:
		if abs(axis.x) > Constants.WALK_RUN_SENSITIVITY * delta:
			return Constants.STATE_NAME.RUN
		else:
			return Constants.STATE_NAME.WALK
	curr_axisx = axis.x
	return Constants.STATE_NAME.CROUCH
