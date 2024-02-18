class_name DoubleJump
extends State

@export var INITIAL_DOUBLEJUMP_FORCE := 600
@export var AIR_MOVE_FORCE := 1000
@export var MAX_AIR_SPEED := 300

var curr_axis: float

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.DOUBLEJUMP

func enter() -> void:
	stateMachine.can_double_jump = false
	character.velocity.y = -INITIAL_DOUBLEJUMP_FORCE
	curr_axis = Input.get_axis("Left", "Right");
	stateMachine.animator.play("DoubleJump")

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	character.velocity.x *= (1 - Constants.FRICTION * delta * 0.1)
	character.velocity.x = character.velocity.x + AIR_MOVE_FORCE * delta * curr_axis
	if (abs(character.velocity.x) > MAX_AIR_SPEED):
		character.velocity.x = clamp(character.velocity.x, -MAX_AIR_SPEED, MAX_AIR_SPEED)
	character.velocity.y += Constants.GRAVITY * delta
	character.move_and_slide()
	if (character.is_on_floor()):
		if abs(curr_axis) > Constants.FLOAT_DEADZONE:
			return Constants.STATE_NAME.RUN
		else:
			return Constants.STATE_NAME.IDLE
	return Constants.STATE_NAME.DOUBLEJUMP

func process(_delta: float) -> Constants.STATE_NAME:
	if (character.velocity.y >= 0):
		return Constants.STATE_NAME.AIR
	curr_axis = Input.get_axis("Left", "Right")
	return Constants.STATE_NAME.DOUBLEJUMP
