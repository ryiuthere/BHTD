class_name StateMachine
extends Node

var current_state: State
var states: Dictionary
@export var animator: AnimationPlayer
@export var character: CharacterBody2D
@export var sprite: AnimatedSprite2D

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.get_state()] = child
	current_state = states[Constants.STATE_NAME.IDLE]
	current_state.enter()

func _physics_process(delta) -> void:
	var next_state = current_state.physics_process(delta)
	enter_state(next_state)

func _process(delta) -> void:
	var next_state = current_state.process(delta)
	enter_state(next_state)

func enter_state(next_state: Constants.STATE_NAME) -> void:
	if next_state != current_state.get_state() and states.has(next_state):
		current_state.exit()
		current_state = states[next_state]
		current_state.enter()
