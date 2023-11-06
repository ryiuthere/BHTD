class_name TempProjectile extends Projectile

func _setup() -> void:
	_behaviour = BasicProjectileBehaviour.new()
	_base_speed = 15
