class_name Airborne
extends State

@export var JUMP_FORCE := 300
@export var AIR_MOVE_FORCE := 1000
@export var MAX_AIR_SPEED := 300
@export var MAX_FALL_SPEED := 450

var curr_axis: float
var falling: bool
var fast_fall: bool

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.AIRBORNE

func enter() -> void:
	character.velocity.y -= JUMP_FORCE
	curr_axis = Input.get_axis("Left", "Right");
	stateMachine.animator.play("Jump")
	falling = false
	fast_fall = false

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	sprite.flip_h = curr_axis < 0
	character.velocity.x *= (1 - Constants.FRICTION * delta * 0.1)
	character.velocity.x = character.velocity.x + AIR_MOVE_FORCE * delta * curr_axis
	if (abs(character.velocity.x) > MAX_AIR_SPEED):
		character.velocity.x = clamp(character.velocity.x, -MAX_AIR_SPEED, MAX_AIR_SPEED)
	if (abs(character.velocity.y) < MAX_FALL_SPEED):
		if fast_fall:
			character.velocity.y = MAX_FALL_SPEED
		else:
			character.velocity.y += Constants.GRAVITY * delta
	character.move_and_slide()
	if (character.is_on_floor()):
		if curr_axis != 0:
			return Constants.STATE_NAME.RUN
		else:
			return Constants.STATE_NAME.IDLE
	return Constants.STATE_NAME.AIRBORNE

func process(delta: float) -> Constants.STATE_NAME:
	if (!falling and character.velocity.y >= 0):
		falling = true
		stateMachine.animator.play("Airborne")
	curr_axis = Input.get_axis("Left", "Right")
	if (!fast_fall and falling and Input.is_action_just_pressed("Down")):
		fast_fall = true
	return Constants.STATE_NAME.AIRBORNE
