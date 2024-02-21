class_name State
extends Node

var stateMachine : StateMachine
var character : CharacterBody2D
var animator : AnimationPlayer
var sprite : AnimatedSprite2D

var prev_axis := Vector2.ZERO
var curr_axis := Vector2.ZERO

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.IDLE

func _ready() -> void:
	stateMachine = get_parent() as StateMachine
	character = stateMachine.character
	animator = stateMachine.animator
	sprite = stateMachine.sprite

func enter() -> void:
	# Start animating, etc.
	pass
	
func exit() -> void:
	# Clean up
	pass

func physics_process(_delta: float) -> Constants.STATE_NAME:
	# Handle physics
	return get_state()

func process(_delta: float) -> Constants.STATE_NAME:
	# Handle input and animation
	get_axis()
	return get_state()

func air_physics(delta: float, apply_friction := true) -> Constants.STATE_NAME:
	if apply_friction:
		character.velocity.x *= (1 - Constants.FRICTION * delta * 0.1)
	character.velocity.y += Constants.GRAVITY * delta
	character.move_and_slide()
	if (character.is_on_floor()):
		if curr_axis.x != 0:
			return Constants.STATE_NAME.RUN
		else:
			return Constants.STATE_NAME.IDLE
	return get_state()

func ground_physics(delta: float, apply_friction := true) -> Constants.STATE_NAME:
	if apply_friction:
		character.velocity.x *= (1 - Constants.FRICTION * delta)
	character.move_and_slide()
	if !character.is_on_floor():
		return Constants.STATE_NAME.AIR
	return get_state()

func get_axis() -> void:
	prev_axis = curr_axis
	curr_axis = Input.get_vector("Left", "Right", "Up", "Down")

func is_down_angle() -> bool:
	var angle = curr_axis.angle()
	return curr_axis.y > 0 and angle > Constants.DOWN_ANGLE_MIN and angle < Constants.DOWN_ANGLE_MAX

func is_up_angle() -> bool:
	var angle = curr_axis.angle()
	return curr_axis.y < 0 and angle > Constants.UP_ANGLE_MIN and angle < Constants.UP_ANGLE_MAX
	
func is_side_angle() -> bool:
	return curr_axis != Vector2.ZERO and !is_down_angle() and !is_up_angle()

func apply_horizontal_movement(delta: float, force: float, max_speed: float) -> void:
	character.velocity.x += force * delta * curr_axis.x
	if (abs(character.velocity.x) > max_speed):
		character.velocity.x = clamp(character.velocity.x, -max_speed, max_speed)

func check_sprite_direction() -> void:
	if abs(curr_axis.x) > Constants.FLOAT_DEADZONE:
		sprite.flip_h = curr_axis.x < 0 

func is_run_input(delta: float) -> bool:
	var distx = curr_axis.x - prev_axis.x
	return abs(distx) > Constants.WALK_RUN_SENSITIVITY * delta and abs(curr_axis.x) >= abs(prev_axis.x)
