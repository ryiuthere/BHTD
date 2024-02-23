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

func check_ground_attack_input() -> bool:
	return stateMachine.attack_states.has(get_ground_attack_from_input(true))

func check_air_attack_input() -> bool:
	return stateMachine.attack_states.has(get_air_attack_from_input(true))

func get_ground_attack_from_input(check_only := false) -> Constants.ATTACK_STATE_NAME:
	if InputBuffer.is_action_press_buffered(Constants.JUMP, !check_only):
		return Constants.ATTACK_STATE_NAME.JUMP
	elif InputBuffer.is_action_press_buffered(Constants.SURGE, !check_only):
		return Constants.ATTACK_STATE_NAME.SURGE
	elif InputBuffer.is_action_press_buffered(Constants.BURST, !check_only):
		return Constants.ATTACK_STATE_NAME.BURST
	elif InputBuffer.is_action_press_buffered(Constants.MID, !check_only) and InputBuffer.is_action_press_buffered(Constants.HEAVY, !check_only):
		return Constants.ATTACK_STATE_NAME.SP
	elif is_up_angle():
		if InputBuffer.is_action_press_buffered(Constants.LIGHT, !check_only):
			return Constants.ATTACK_STATE_NAME.L8 
		elif InputBuffer.is_action_press_buffered(Constants.MID, !check_only):
			return Constants.ATTACK_STATE_NAME.M8
		elif InputBuffer.is_action_press_buffered(Constants.HEAVY, !check_only):
			return Constants.ATTACK_STATE_NAME.H8
	elif is_side_angle():
		if InputBuffer.is_action_press_buffered(Constants.LIGHT, !check_only):
			return Constants.ATTACK_STATE_NAME.L6 
		elif InputBuffer.is_action_press_buffered(Constants.MID, !check_only):
			return Constants.ATTACK_STATE_NAME.M6
		elif InputBuffer.is_action_press_buffered(Constants.HEAVY, !check_only):
			return Constants.ATTACK_STATE_NAME.H6
	elif is_down_angle():
		if InputBuffer.is_action_press_buffered(Constants.LIGHT, !check_only):
			return Constants.ATTACK_STATE_NAME.L2
		elif InputBuffer.is_action_press_buffered(Constants.MID, !check_only):
			return Constants.ATTACK_STATE_NAME.M2
		elif InputBuffer.is_action_press_buffered(Constants.HEAVY, !check_only):
			return Constants.ATTACK_STATE_NAME.H2
	else:
		if InputBuffer.is_action_press_buffered(Constants.LIGHT, !check_only):
			return Constants.ATTACK_STATE_NAME.L5 
		elif InputBuffer.is_action_press_buffered(Constants.MID, !check_only):
			return Constants.ATTACK_STATE_NAME.M5
		elif InputBuffer.is_action_press_buffered(Constants.HEAVY, !check_only):
			return Constants.ATTACK_STATE_NAME.H5
	return Constants.ATTACK_STATE_NAME.NONE

func get_air_attack_from_input(check_only := false) -> Constants.ATTACK_STATE_NAME:
	if InputBuffer.is_action_press_buffered(Constants.JUMP, !check_only):
		return Constants.ATTACK_STATE_NAME.JUMP
	elif InputBuffer.is_action_press_buffered(Constants.SURGE, !check_only):
		return Constants.ATTACK_STATE_NAME.SURGE
	elif InputBuffer.is_action_press_buffered(Constants.BURST, !check_only):
		return Constants.ATTACK_STATE_NAME.BURST
	elif InputBuffer.is_action_press_buffered(Constants.MID, !check_only) and InputBuffer.is_action_press_buffered(Constants.HEAVY, !check_only):
		return Constants.ATTACK_STATE_NAME.ASP
	elif is_up_angle():
		if InputBuffer.is_action_press_buffered(Constants.LIGHT, !check_only):
			return Constants.ATTACK_STATE_NAME.AL8 
		elif InputBuffer.is_action_press_buffered(Constants.MID, !check_only):
			return Constants.ATTACK_STATE_NAME.AM8
	elif is_side_angle():
		if InputBuffer.is_action_press_buffered(Constants.LIGHT, !check_only):
			var sprite_flipped = -1 if sprite.flip_h else 1
			if sprite_flipped * curr_axis.x > 0:
				return Constants.ATTACK_STATE_NAME.AL6
			else:
				return Constants.ATTACK_STATE_NAME.AL4
		elif InputBuffer.is_action_press_buffered(Constants.MID, !check_only):
			return Constants.ATTACK_STATE_NAME.AM6
	elif is_down_angle():
		if InputBuffer.is_action_press_buffered(Constants.LIGHT, !check_only):
			return Constants.ATTACK_STATE_NAME.AL2
		elif InputBuffer.is_action_press_buffered(Constants.MID, !check_only):
			return Constants.ATTACK_STATE_NAME.AM2
	else:
		if InputBuffer.is_action_press_buffered(Constants.LIGHT, !check_only):
			return Constants.ATTACK_STATE_NAME.AL5 
		elif InputBuffer.is_action_press_buffered(Constants.MID, !check_only):
			return Constants.ATTACK_STATE_NAME.AM5
	return Constants.ATTACK_STATE_NAME.NONE
