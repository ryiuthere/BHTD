class_name Hitbox
extends Area2D

@export var collider : CollisionShape2D
var controller : HitboxController

func _ready() -> void:
	cleanup()
	queue_redraw()

func cleanup() -> void:
	collider.disabled = true
	collider.visible = false

func _draw() -> void:
	if controller.debug and !collider.disabled:
		var hitbox_position = collider.position
		if controller.sprite.flip_h:
			hitbox_position.x = hitbox_position.x * -1
		draw_rect(Rect2(hitbox_position - collider.shape.extents + controller.character.global_position - global_position,
			collider.shape.extents * 2), collider.debug_color)

func _on_collision_shape_2d_visibility_changed():
	collider.disabled = !collider.visible
	queue_redraw()
