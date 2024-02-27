class_name Attack
extends State

var attacks : Dictionary
var current_attack : GroundAttackState
var can_cancel_attack : bool:
	get:
		return stateMachine.cancel_frames > 0

func _ready() -> void:
	super()
	for child in get_children():
		if child is GroundAttackState:
			child.setup(stateMachine)
			attacks[child.get_attack_state()] = child
			stateMachine.ground_attack_states[child.get_attack_state()] = child
	current_attack = null

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.ATTACK

func enter() -> void:
	var attack := get_ground_attack_from_input()
	try_start_attack(attack)

func exit() -> void:
	# Clean up hitboxes
	stateMachine.attack_status = Constants.ATTACK_STATUS.NONE
	stateMachine.hitbox_controller.cleanup()
	current_attack = null
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	if current_attack != null:
		return current_attack.physics_process(delta)
	else:
		return Constants.STATE_NAME.IDLE

func process(delta: float) -> Constants.STATE_NAME:
	super(delta)
	if current_attack != null:
		var next_action := current_attack.process_attack(delta)
		if next_action == Constants.ATTACK_STATE_NAME.CONTINUE:		
			return get_state()
		elif next_action == Constants.ATTACK_STATE_NAME.JUMP:
			return Constants.STATE_NAME.JUMP
		elif next_action == Constants.ATTACK_STATE_NAME.NONE:
			pass
		elif !can_cancel_attack or (can_cancel_attack and try_start_attack(next_action)):
			return get_state()
	var attack_input := get_ground_attack_from_input()
	if attack_input != Constants.ATTACK_STATE_NAME.NONE and try_start_attack(attack_input):
		return get_state()
	if is_down_angle():
		return Constants.STATE_NAME.CROUCH
	else:
		return Constants.STATE_NAME.IDLE

func try_start_attack(attack : Constants.ATTACK_STATE_NAME) -> bool:
	if attacks.has(attack):
		stateMachine.attack_status = Constants.ATTACK_STATUS.STARTUP
		check_sprite_direction()
		if current_attack != null:
			current_attack.exit()
		current_attack = attacks[attack]
		current_attack.enter()
		return true
	return false
