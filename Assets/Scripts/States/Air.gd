class_name Air
extends State

@export var JUMP_FORCE := 800
@export var AIR_MOVE_FORCE := 1000
@export var MAX_AIR_SPEED := 300
@export var MAX_FALL_SPEED := 350

var fast_fall: bool

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.AIR

func enter() -> void:
	stateMachine.animator.play("Air")
	fast_fall = false

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	apply_horizontal_movement(delta, AIR_MOVE_FORCE, MAX_AIR_SPEED)
	if fast_fall:
		character.velocity.y = MAX_FALL_SPEED + 150
	return air_physics(delta)

func process(delta: float) -> Constants.STATE_NAME:
	super(delta)
	if (InputBuffer.is_action_press_buffered("Jump") and stateMachine.can_double_jump):
		return Constants.STATE_NAME.DOUBLEJUMP
	if (!fast_fall and InputBuffer.is_action_press_buffered("Down")):
		fast_fall = true
	return Constants.STATE_NAME.AIR
