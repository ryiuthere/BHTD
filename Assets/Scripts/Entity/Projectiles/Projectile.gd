class_name Projectile extends Entity

var _behaviour : ProjectileBehaviour

var target : Entity

func initialize(position : Vector2, direction : Vector2) -> void:
	self.position = position
	_target_direction = direction.normalized()
	rotation = direction.angle() - PI/2
	_setup()

func act() -> void:
	if _behaviour != null:
		_behaviour.act(self)

func _physics_process(delta: float) -> void:
	super(delta)
	act()

func _setup() -> void:
	pass
