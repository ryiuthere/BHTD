class_name HitboxController
extends Node2D

@export var debug := true
@export var character : Node2D
@export var sprite : AnimatedSprite2D
	
var hitboxes : Array
var hurtboxes : Array

var id : int
var attack_active := false

signal attack_status_changed(status: bool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	id = Constants.next_id()
	for child in get_children():
		if child is Hitbox:
			child.controller = self
			hitboxes.append(child)
		elif child is Hurtbox:
			child.controller = self
			hitboxes.append(child)

func _process(_delta: float) -> void:
	for hitbox in hitboxes:
		if hitbox is Hitbox and hitbox.collider.visible:
			set_attack_status(true)
			return
	set_attack_status(false)

func cleanup() -> void:
	for hitbox in hitboxes:
		if hitbox is Hitbox:
			hitbox.cleanup()
	for hurtbox in hurtboxes:
		if hurtbox is Hurtbox:
			hurtbox.cleanup()
	set_attack_status(false)

func _on_hitbox_area_entered(area : Area2D) -> void:
	if area is Hurtbox and area.controller != null and area.controller.id != id:
		# TODO
		pass

func _on_hurtbox_area_entered(area : Area2D) -> void:
	if area is Hitbox  and area.controller != null and area.controller.id != id:
		# TODO
		pass

func set_attack_status(active: bool) -> void:
	if attack_active != active:
				attack_status_changed.emit(active)
				attack_active = active
