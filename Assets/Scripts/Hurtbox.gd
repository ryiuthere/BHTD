class_name Hurtbox
extends Area2D

@export var collider : CollisionShape2D
var controller : HitboxController

func _ready() -> void:
	cleanup()

func cleanup() -> void:
	collider.disabled = false
	visible = false

func _on_collision_shape_2d_visibility_changed():
	collider.disabled = !visible
