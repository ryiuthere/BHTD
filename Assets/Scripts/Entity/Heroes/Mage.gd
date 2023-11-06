class_name Mage extends Hero

# Called when the node enters the scene tree for the first time.
func _setup():
	_base_speed = 20
	_auto_attack = Constants.Projectile.TempProjectile
