class_name AttackState
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
	pass

func physics_process(_delta: float) -> Constants.ATTACK_STATE_NAME:
	# Handle physics
	return Constants.ATTACK_STATE_NAME.L5

func process(_delta: float) -> Constants.ATTACK_STATE_NAME:
	# Handle input and animation
	return Constants.ATTACK_STATE_NAME.L5
