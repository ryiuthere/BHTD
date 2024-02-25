class_name Hurtbox
extends Area2D

@export var collider : CollisionShape2D
var controller : HitboxController

func cleanup() -> void:
	collider.disabled = false
	visible = false

func _draw() -> void:
	if controller.debug and !collider.disabled:
		var hitbox_position = collider.position
		draw_rect(Rect2(hitbox_position - collider.shape.extents + controller.character.global_position - global_position,
			collider.shape.extents * 2), collider.debug_color)

func _on_collision_shape_2d_visibility_changed():
	collider.disabled = !visible
	queue_redraw()
