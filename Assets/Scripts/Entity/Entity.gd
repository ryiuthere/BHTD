class_name Entity extends CharacterBody2D

var _status := EntityStatus.new(1000);
var _base_speed := 10
var _target_direction : Vector2

@export var animator: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.ds

func set_direction(dir: Vector2) -> void:
	_target_direction = dir.normalized()

func _physics_process(delta):
	if _target_direction.length() > 0:
		velocity = _target_direction * _base_speed / 5
	else:
		velocity = Vector2.ZERO
	print(name + ": " + str(velocity.x).pad_decimals(4) + ", " + str(velocity.y).pad_decimals(4))
	move_and_collide(velocity)
	# TODO: Figure out why move_and_slide seems so buggy
