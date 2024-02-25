class_name State
extends BaseState

func _ready() -> void:
	stateMachine = get_parent() as StateMachine
	character = stateMachine.character
	animator = stateMachine.animator
	sprite = stateMachine.sprite

func physics_process(_delta: float) -> Constants.STATE_NAME:
	# Handle physics
	return get_state()

func process(_delta: float) -> Constants.STATE_NAME:
	# Handle input
	get_axis()
	return get_state()
