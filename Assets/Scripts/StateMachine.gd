class_name StateMachine
extends Node

signal debug_status_change(next_state: Constants.ATTACK_STATUS)

var current_state: State
var states: Dictionary
var ground_attack_states: Dictionary
var air_attack_states: Dictionary
@export var animator: AnimationPlayer
@export var character: CharacterBody2D
@export var sprite: AnimatedSprite2D
@export var hitbox_controller: HitboxController

@export var attack_status := Constants.ATTACK_STATUS.NONE
@onready var last_attack_status := Constants.ATTACK_STATUS.NONE

@export var INITIAL_JUMP_FORCE := 400
@export var CONSTANT_JUMP_FORCE := 800
@export var INITIAL_DOUBLEJUMP_FORCE := 600
@export var AIR_MOVE_FORCE := 1000
@export var MAX_AIR_SPEED := 300
@export var MAX_FALL_SPEED := 350
@export var WALK_FORCE := 3000
@export var MAX_WALK_SPEED := 100
@export var RUN_FORCE := 3000
@export var MAX_RUN_SPEED := 300

var can_double_jump := false
var hitstop_frames := -1
var hitstun_frames := 0
var hitbox_ids : Dictionary

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.get_state()] = child
	current_state = states[Constants.STATE_NAME.AIR]
	current_state.enter()
	character.velocity.y = 0

func _physics_process(delta) -> void:
	var next_state = current_state.physics_process(delta)
	enter_state(next_state)

func _process(delta) -> void:
	for hitbox_id in hitbox_ids:
		hitbox_ids[hitbox_id] -= 1
		if hitbox_ids[hitbox_id] <= 0:
			hitbox_ids.erase(hitbox_id)
	if hitstop_frames > 0:
		animator.pause()
		hitstop_frames -= 1
	else:
		if hitstop_frames == 0:
			animator.play()
			hitstop_frames -= 1
		if hitstun_frames > 0:
			hitstun_frames -= 1
		var next_state = current_state.process(delta)
		enter_state(next_state)
	check_for_new_attack_status()

func enter_state(next_state: Constants.STATE_NAME) -> void:
	if next_state != current_state.get_state() and states.has(next_state):
		current_state.exit()
		current_state = states[next_state]
		current_state.get_axis()
		current_state.enter()

func check_for_new_attack_status() -> void:
	if last_attack_status != attack_status:
		debug_status_change.emit(attack_status)
		last_attack_status = attack_status

func on_attack_status_change(active: bool) -> void:
	if active and attack_status == Constants.ATTACK_STATUS.STARTUP or attack_status == Constants.ATTACK_STATUS.RECOVERY:
		attack_status = Constants.ATTACK_STATUS.ACTIVE
	elif !active and attack_status == Constants.ATTACK_STATUS.ACTIVE:
		attack_status = Constants.ATTACK_STATUS.RECOVERY

func apply_hitbox(hitbox: Hitbox) -> bool:
	if !hitbox_ids.has(hitbox.group_id):
		hitbox_ids[hitbox.group_id] = Constants.HITBOX_REAPPLY_FRAMES
		if !hitbox.knockback.vector.is_zero_approx():
			if hitstun_frames == 0:
				character.velocity = Vector2.ZERO
			var knockback_vector = hitbox.knockback.vector
			if hitbox.flipped:
				knockback_vector.x *= -1
			character.velocity += knockback_vector
		hitstun_frames = hitbox.hitstun
		hitstop_frames = hitbox.hitstop
		hitbox.controller.state_machine.apply_hitstop(hitbox.hitstop)
		return hitstun_frames > 0
	return false

func apply_hitstop(frames: int) -> void:
	hitstop_frames = frames
