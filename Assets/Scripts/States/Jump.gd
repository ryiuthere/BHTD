class_name Jump
extends State

@export var INITIAL_JUMP_FORCE := 400
@export var CONSTANT_JUMP_FORCE := 800
@export var AIR_MOVE_FORCE := 1000
@export var MAX_AIR_SPEED := 300

var curr_axis: float
var falling: bool
var fast_fall: bool
var jump_hold: bool

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.JUMP

func enter() -> void:
	character.velocity.y -= INITIAL_JUMP_FORCE
	curr_axis = Input.get_axis("Left", "Right");
	stateMachine.animator.play("Jump")
	jump_hold = true

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	character.velocity.x *= (1 - Constants.FRICTION * delta * 0.1)
	character.velocity.x = character.velocity.x + AIR_MOVE_FORCE * delta * curr_axis
	if (abs(character.velocity.x) > MAX_AIR_SPEED):
		character.velocity.x = clamp(character.velocity.x, -MAX_AIR_SPEED, MAX_AIR_SPEED)
	if (jump_hold):
		character.velocity.y += (Constants.GRAVITY - CONSTANT_JUMP_FORCE) * delta
	else:
		character.velocity.y += Constants.GRAVITY * delta
	character.move_and_slide()
	if (character.is_on_floor()):
		if abs(curr_axis) > Constants.FLOAT_DEADZONE:
			return Constants.STATE_NAME.RUN
		else:
			return Constants.STATE_NAME.IDLE
	return Constants.STATE_NAME.JUMP

func process(_delta: float) -> Constants.STATE_NAME:
	if (!falling and character.velocity.y >= 0):
		return Constants.STATE_NAME.AIR
	curr_axis = Input.get_axis("Left", "Right")
	if (!fast_fall and falling and InputBuffer.is_action_press_buffered("Down")):
		fast_fall = true
	if (jump_hold and !Input.is_action_pressed("Jump")):
		jump_hold = false
	return Constants.STATE_NAME.JUMP
