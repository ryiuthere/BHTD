extends Node2D

@export var SIZE_FRAMES := 60
@export var RECT_SIZE := 10

@onready var frames_elapsed := 0
@onready var subframe_timer : float
@onready var container := $HBoxContainer

@onready var acted_during_this_cycle := false
@onready var active := false


enum STATES {CLEAR, STARTUP, ACTIVE, RECOVERY, MOVEMENT}
@onready var current_state := STATES.CLEAR

const colors := [Color(1, 1, 1), Color(0, 1, 0.65), Color(1, 0, 0.3), Color(0.333, 0, 1), Color(1, 0.851, 0)]
"""
0 - Clear
1 - Atk Startup
2 - Atk Active
3 - Atk Recovery
4 - Uncancellable Movement 
"""
	
func setup_add_rect(parent : HBoxContainer) -> void:
	var rect = ColorRect.new()
	rect.custom_minimum_size.x = RECT_SIZE
	parent.add_child(rect)
	

func reset() -> void:
	for rect in container.get_children():
		rect.color = colors[0]
		rect.color.a = 0.2
	
	
func container_setup() -> void:
	container.size.x = (RECT_SIZE + 1) * SIZE_FRAMES - 1
	container.size.y = RECT_SIZE
	for i in range(SIZE_FRAMES):
		setup_add_rect(container)
	reset()


func set_all_to_off() -> void:
	var rects = container.get_children()
	for r in range(1, len(rects)):
		rects[r].color.a = 0.2
		
		
func update_rect(index : int) -> void:
	var rect = container.get_child(index)
	if current_state != STATES.CLEAR:
		acted_during_this_cycle = true
		rect.color = colors[current_state]
		rect.color.a = 1.0
	else:
		rect.color = colors[STATES.CLEAR]
		rect.color.a = 0.2
		
	
func increment_time(delta) -> void:
	var fps := 60
	subframe_timer += delta
	if subframe_timer >= 1.0 / fps:
		subframe_timer -= 1.0 / fps
		frames_elapsed += 1


func _ready() -> void:
	container_setup()


func _process(delta):
	if active:
		if frames_elapsed == 0:
			set_all_to_off()
			if current_state == STATES.CLEAR:
				update_rect(0)
		update_rect(frames_elapsed)
		increment_time(delta)
		if frames_elapsed >= SIZE_FRAMES:
			if acted_during_this_cycle:
				acted_during_this_cycle = false
			else:
				active = false
			frames_elapsed = 0
		$FrameMeterText.text = "FM On - Frame %s" % (frames_elapsed + 1)
	else:
		$FrameMeterText.text = "FM Off"
	

func _update_framemeter_state(attack_state : Constants.ATTACK_STATUS) -> void:
	match attack_state:
		Constants.ATTACK_STATUS.NONE: current_state = STATES.CLEAR
		Constants.ATTACK_STATUS.STARTUP: current_state = STATES.STARTUP
		Constants.ATTACK_STATUS.ACTIVE: current_state = STATES.ACTIVE
		Constants.ATTACK_STATUS.RECOVERY: current_state = STATES.RECOVERY
		Constants.ATTACK_STATUS.MOVEMENT: current_state = STATES.MOVEMENT
	if not active and current_state != STATES.CLEAR:
		active = true
