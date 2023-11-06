class_name Hero extends Entity

var _auto_attack := Constants.Projectile.TempProjectile
var _auto_attack_speed := 60
var _auto_attack_range := 300

var _auto_attack_timer := 0

func _ready() -> void:
	_setup()

func set_current() -> void:
	GameController.set_camera_focus(self)
	
func _setup() -> void:
	pass

func auto_attack() -> void:
	var entity = GameController.entity_manager.closest_enemy(position, _auto_attack_range)
	if entity != null:
		GameController.entity_manager.create_projectile(_auto_attack, position, entity.position - position)

func _physics_process(delta: float) -> void:
	super(delta)
	_auto_attack_timer -= delta
	if _auto_attack_timer <= 0:
		auto_attack()
		_auto_attack_timer = _auto_attack_speed
