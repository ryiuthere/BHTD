class_name Hitbox
extends Area2D

@export var collider : CollisionShape2D
@export var knockback : VectorTool
@export var damage : int
@export var hitstun : int
@export var hitstop : int
@export var group_priority := 1

var controller : HitboxController
var group_id : int
var flipped : bool

func _ready() -> void:
	cleanup()
	queue_redraw()

func cleanup() -> void:
	collider.disabled = true
	collider.visible = false

func _draw() -> void:
	if controller.debug and !collider.disabled:
		var hitbox_position = collider.position
		draw_rect(Rect2(hitbox_position - collider.shape.extents + controller.character.global_position - global_position,
			collider.shape.extents * 2), collider.debug_color)

func _on_collision_shape_2d_visibility_changed():
	collider.disabled = !collider.visible
	queue_redraw()
