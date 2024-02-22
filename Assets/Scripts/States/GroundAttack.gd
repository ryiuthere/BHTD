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
	check_sprite_direction()
	var attack := get_attack_from_input()
	if attacks.has(attack):
		current_attack = attacks[attack]
		current_attack.enter()

func exit() -> void:
	# Clean up hitboxes
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
		var attack_input := get_attack_from_input()
		var next_action := current_attack.process_attack(delta, attack_input)
		if next_action == Constants.NEXT_ATTACK_ACTION.CONTINUE:
			return get_state()
		elif next_action == Constants.NEXT_ATTACK_ACTION.GROUND_ATTACK:
			current_attack = attacks[attack_input]
		elif next_action == Constants.NEXT_ATTACK_ACTION.AIR_ATTACK:
			return Constants.STATE_NAME.AIRATTACK
		elif next_action == Constants.NEXT_ATTACK_ACTION.JUMP:
			return Constants.STATE_NAME.JUMP
	if is_down_angle():
		return Constants.STATE_NAME.CROUCH
	else:
		return Constants.STATE_NAME.IDLE

func get_attack_from_input() -> Constants.ATTACK_STATE_NAME:
	if InputBuffer.is_action_press_buffered(Constants.JUMP):
		return Constants.ATTACK_STATE_NAME.JUMP
	elif InputBuffer.is_action_press_buffered(Constants.BURST):
		return Constants.ATTACK_STATE_NAME.BURST
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
