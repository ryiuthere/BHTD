class_name Hero extends CharacterBody2D

var _status = EntityStatus.New(1000);
var _base_speed = 10
var _target_direction : Vector2

func set_current() -> void:
	GameController.set_camera_focus(self)

func set_direction(dir: Vector2) -> void:
	_target_direction = dir

func _physics_process(_delta):
	if _target_direction.length() > 0:
		velocity = _target_direction * _delta * 1000 * _base_speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
