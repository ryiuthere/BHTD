class_name Jump
extends State

@export var INITIAL_JUMP_FORCE := 400
@export var CONSTANT_JUMP_FORCE := 800
@export var AIR_MOVE_FORCE := 1000
@export var MAX_AIR_SPEED := 300

var jump_hold: bool

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.JUMP

func enter() -> void:
	stateMachine.can_double_jump = true
	character.velocity.y = -INITIAL_JUMP_FORCE
	stateMachine.animator.play(Constants.JUMP)
	jump_hold = true

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	if (character.velocity.y >= 0):
		return Constants.STATE_NAME.AIR
	apply_horizontal_movement(delta, AIR_MOVE_FORCE, MAX_AIR_SPEED)
	if (jump_hold):
		character.velocity.y += -CONSTANT_JUMP_FORCE * delta
	return air_physics(delta)

func process(delta: float) -> Constants.STATE_NAME:
	super(delta)
	if (!jump_hold and InputBuffer.is_action_press_buffered(Constants.JUMP) and stateMachine.can_double_jump):
		return Constants.STATE_NAME.DOUBLEJUMP
	elif is_attack_input():
		return Constants.STATE_NAME.AIRATTACK
	if (jump_hold and !Input.is_action_pressed(Constants.JUMP) and !InputBuffer.is_action_press_buffered(Constants.JUMP)):
		jump_hold = false
	return Constants.STATE_NAME.JUMP
