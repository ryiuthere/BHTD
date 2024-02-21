class_name Attack
extends State

var attacks : Dictionary
var current_attack : AttackState

func _ready() -> void:
	attacks[Constants.ATTACK_STATE_NAME.NONE] = null
	for child in get_children():
		if child is AttackState:
			attacks[child.get_state()] = child
	current_attack = attacks[Constants.ATTACK_STATE_NAME.NONE]

func get_state() -> Constants.STATE_NAME:
	return Constants.STATE_NAME.IDLE

func enter() -> void:
	# TODO
	pass

func exit() -> void:
	pass

func physics_process(delta: float) -> Constants.STATE_NAME:
	if current_attack != null:
		var next_attack = current_attack.physics_process(delta)
		if next_attack == Constants.ATTACK_STATE_NAME.NONE:
			return Constants.STATE_NAME.IDLE
		else:
			current_attack = attacks[next_attack]
			return ground_physics(delta)
	else:
		return Constants.STATE_NAME.IDLE

func process(delta: float) -> Constants.STATE_NAME:
	super(delta)
	if current_attack != null:
		var next_attack = current_attack.process(delta)
		if next_attack == Constants.ATTACK_STATE_NAME.NONE:
			return Constants.STATE_NAME.IDLE
		else:
			current_attack = attacks[next_attack]
			return get_state()
	else:
		return Constants.STATE_NAME.IDLE

func get_attack_from_input() -> Constants.ATTACK_STATE_NAME:
	if InputBuffer.is_action_press_buffered("Jump"):
		return Constants.ATTACK_STATE_NAME.JUMP
	elif InputBuffer.is_action_press_buffered("Burst"):
		return Constants.ATTACK_STATE_NAME.BURST
	
	else:
		return Constants.ATTACK_STATE_NAME.NONE
