class_name GroundAttackState
extends Node

var stateMachine : StateMachine
var character : CharacterBody2D
var animator : AnimationPlayer
var sprite : AnimatedSprite2D

func get_state() -> Constants.ATTACK_STATE_NAME:
	return Constants.ATTACK_STATE_NAME.L5

func setup(stateHandler: StateMachine) -> void:
	stateMachine = stateHandler as StateMachine
	character = stateMachine.character
	animator = stateMachine.animator
	sprite = stateMachine.sprite

func enter() -> void:
	# Start animating, etc.
	pass
	
func exit() -> void:
	# Clean up
	stateMachine.attack_status = Constants.ATTACK_STATUS.NONE
	pass

func physics_process(_delta: float) -> void:
	# Handle physics
	pass

func process_attack(_delta: float, _attack: Constants.ATTACK_STATE_NAME) -> Constants.NEXT_ATTACK_ACTION:
	# Handle input
	if stateMachine.attack_status == Constants.ATTACK_STATUS.NONE:
		return Constants.NEXT_ATTACK_ACTION.NONE
	else:
		return Constants.NEXT_ATTACK_ACTION.CONTINUE
