class_name BaseState
extends Node

var stateMachine : StateMachine
var character : CharacterBody2D
var animator : AnimationPlayer
var sprite : AnimatedSprite2D

var prev_axis := Vector2.ZERO
var curr_axis := Vector2.ZERO

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

func is_attack_input() -> bool:
	var light = InputBuffer.is_action_press_buffered(Constants.LIGHT, false)
	var mid = InputBuffer.is_action_press_buffered(Constants.MID, false)
	var heavy = InputBuffer.is_action_press_buffered(Constants.HEAVY, false)
	return light or mid or heavy
