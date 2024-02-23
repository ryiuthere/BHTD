class_name Attack
extends State

var attacks : Dictionary
var current_attack : GroundAttackState

func _ready() -> void:
	super()
	for child in get_children():
		if child is GroundAttackState:
			child.setup(stateMachine)
			attacks[child.get_state()] = child
	current_attack = null

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.ATTACK

func enter() -> void:
	var attack := get_attack_from_input()
	try_start_attack(attack)

func exit() -> void:
	# Clean up hitboxes
	stateMachine.attack_status = Constants.ATTACK_STATUS.NONE
	stateMachine.hitbox_controller.cleanup()
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	if current_attack != null:
		current_attack.physics_process(delta)
		return ground_physics(delta)
	else:
		return Constants.STATE_NAME.IDLE

func process(delta: float) -> Constants.STATE_NAME:
	super(delta)
	if current_attack != null:
		var next_action := current_attack.process_attack(delta)
		if next_action == current_attack.get_state():
			return get_state()
		elif next_action == Constants.ATTACK_STATE_NAME.JUMP:
			return Constants.STATE_NAME.JUMP
		elif next_action == Constants.ATTACK_STATE_NAME.NONE:
			pass
		else:
			if try_start_attack(next_action):
				return get_state()
	var attack_input := get_attack_from_input()
	if attack_input != Constants.ATTACK_STATE_NAME.NONE and try_start_attack(attack_input):
		return get_state()
	if is_down_angle():
		return Constants.STATE_NAME.CROUCH
	else:
		return Constants.STATE_NAME.IDLE

func get_attack_from_input() -> Constants.ATTACK_STATE_NAME:
	if InputBuffer.is_action_press_buffered(Constants.JUMP):
		return Constants.ATTACK_STATE_NAME.JUMP
	elif InputBuffer.is_action_press_buffered(Constants.SURGE):
		return Constants.ATTACK_STATE_NAME.SURGE
	elif InputBuffer.is_action_press_buffered(Constants.BURST):
		return Constants.ATTACK_STATE_NAME.BURST
	elif InputBuffer.is_action_press_buffered(Constants.MID) and InputBuffer.is_action_press_buffered(Constants.HEAVY):
		return Constants.ATTACK_STATE_NAME.SP
	elif is_up_angle():
		if InputBuffer.is_action_press_buffered(Constants.LIGHT):
			return Constants.ATTACK_STATE_NAME.L8 
		elif InputBuffer.is_action_press_buffered(Constants.MID):
			return Constants.ATTACK_STATE_NAME.M8
		elif InputBuffer.is_action_press_buffered(Constants.HEAVY):
			return Constants.ATTACK_STATE_NAME.H8
	elif is_side_angle():
		if InputBuffer.is_action_press_buffered(Constants.LIGHT):
			return Constants.ATTACK_STATE_NAME.L6 
		elif InputBuffer.is_action_press_buffered(Constants.MID):
			return Constants.ATTACK_STATE_NAME.M6
		elif InputBuffer.is_action_press_buffered(Constants.HEAVY):
			return Constants.ATTACK_STATE_NAME.H6
	elif is_down_angle():
		if InputBuffer.is_action_press_buffered(Constants.LIGHT):
			return Constants.ATTACK_STATE_NAME.L2
		elif InputBuffer.is_action_press_buffered(Constants.MID):
			return Constants.ATTACK_STATE_NAME.M2
		elif InputBuffer.is_action_press_buffered(Constants.HEAVY):
			return Constants.ATTACK_STATE_NAME.H2
	else:
		if InputBuffer.is_action_press_buffered(Constants.LIGHT):
			return Constants.ATTACK_STATE_NAME.L5 
		elif InputBuffer.is_action_press_buffered(Constants.MID):
			return Constants.ATTACK_STATE_NAME.M5
		elif InputBuffer.is_action_press_buffered(Constants.HEAVY):
			return Constants.ATTACK_STATE_NAME.H5
	return Constants.ATTACK_STATE_NAME.NONE

func try_start_attack(attack : Constants.ATTACK_STATE_NAME) -> bool:
	if attacks.has(attack):
		stateMachine.attack_status = Constants.ATTACK_STATUS.STARTUP
		check_sprite_direction()
		current_attack = attacks[attack]
		current_attack.enter()
		return true
	return false
