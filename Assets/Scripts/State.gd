class_name State
extends BaseState

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
	return get_state()

func process(_delta: float) -> Constants.STATE_NAME:
	# Handle input
	get_axis()
	return get_state()

func air_physics(delta: float, apply_friction := true) -> Constants.STATE_NAME:
	if apply_friction:
		character.velocity.x *= (1 - Constants.FRICTION * delta * 0.1)
	character.velocity.y += Constants.GRAVITY * delta
	character.move_and_slide()
	if (character.is_on_floor()):
		if curr_axis.x != 0:
			return Constants.STATE_NAME.RUN
		else:
			return Constants.STATE_NAME.IDLE
	return get_state()

func ground_physics(delta: float, apply_friction := true) -> Constants.STATE_NAME:
	if apply_friction:
		character.velocity.x *= (1 - Constants.FRICTION * delta)
	character.move_and_slide()
	if !character.is_on_floor():
		return Constants.STATE_NAME.AIR
	return get_state()
