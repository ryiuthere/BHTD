class_name State
extends Node

var stateMachine : StateMachine
var character : CharacterBody2D
var animator : AnimationPlayer
var sprite : AnimatedSprite2D

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
	return Constants.STATE_NAME.IDLE

func process(_delta: float) -> Constants.STATE_NAME:
	# Handle input and animation
	return Constants.STATE_NAME.IDLE
