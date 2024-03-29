extends Control
@export var player : CharacterBody2D
@onready var frame_meter := $DebugFrameMeter as DebugFrameMeter
var state_machine : StateMachine

func _ready() -> void:
	state_machine = player.get_node("StateMachine")
	state_machine.debug_status_change.connect(_on_update_framemeter_state)

func _on_update_framemeter_state(next_state: Constants.ATTACK_STATUS) -> void:
	frame_meter._update_framemeter_state(next_state)
