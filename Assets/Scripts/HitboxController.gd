class_name HitboxController
extends Node2D

@export var debug := true
@export var character : Node2D
@export var sprite : AnimatedSprite2D
@export var state_machine : StateMachine
	
var hitboxes : Array
var hurtboxes : Array

var id : int
var next_hitbox_id : int
var attack_active := false

signal attack_status_changed(status: bool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	id = Constants.next_hitbox_controller_id()
	for child in get_children():
		if child is Hitbox:
			child.controller = self
			hitboxes.append(child)
		elif child is Hurtbox:
			child.controller = self
			hurtboxes.append(child)

func _process(_delta: float) -> void:
	scale.x = -1 if sprite.flip_h else 1
	var active := false
	for hitbox in hitboxes:
		if hitbox is Hitbox and hitbox.collider.visible:
			active = true
			hitbox.group_id = next_hitbox_id
			hitbox.flipped = sprite.flip_h
	set_attack_status(active)

func cleanup() -> void:
	for hitbox in hitboxes:
		if hitbox is Hitbox:
			hitbox.cleanup()
	set_attack_status(false)

func get_incoming_hitboxes(delta: float) -> Array:
	var incoming_hitboxes : Dictionary = {}
	var overlapping_hurtboxes : Dictionary = {}
	for hurtbox in hurtboxes:
		if hurtbox is Hurtbox:
			for area in hurtbox.get_overlapping_areas():
				if area is Hitbox and area.controller.id != hurtbox.controller.id:
					if incoming_hitboxes.has(area.group_id) and incoming_hitboxes[area.group_id].group_priority < area.group_priority:
						incoming_hitboxes[area.group_id] = area
					else:
						incoming_hitboxes[area.group_id] = area
				if area is Hurtbox and area.controller.id != hurtbox.controller.id:
					overlapping_hurtboxes[hurtbox.controller.id] = area.controller.state_machine
	var result : Array = []
	for hitbox in incoming_hitboxes:
		result.append(incoming_hitboxes[hitbox])
	for group_id in overlapping_hurtboxes:
		var target := overlapping_hurtboxes[group_id] as StateMachine
		var direction := 1 if state_machine.character.position.x - target.character.position.x > 0 else -1
		var dist := pow(state_machine.character.position.x - target.character.position.x, 2)
		var force = delta * Constants.HURTBOX_PUSH_FORCE / (dist + 1) * direction
		state_machine.hurtbox_push(force)
	return result

func set_attack_status(active: bool) -> void:
	if attack_active != active:
		if attack_active:
			next_hitbox_id = Constants.next_hitbox_id()
		attack_status_changed.emit(active)
		attack_active = active
