class_name Entity extends CharacterBody2D

var _status := EntityStatus.new(1000);
var _base_speed := 10
var _target_direction : Vector2

@export var animator: AnimatedSprite2D

func set_direction(dir: Vector2) -> void:
	_target_direction = dir.normalized()

func _physics_process(delta):
	if _target_direction.length() > 0:
		velocity = _target_direction * _base_speed / 5
	else:
		velocity = Vector2.ZERO
	move_and_collide(velocity)
	# TODO: Figure out why move_and_slide seems so buggy
