class_name EntityStatus
	
var _max_health := 1000
var _health := 1000
var _condition := { Constants.Condition.OK: true }

static func New(max_health) -> EntityStatus:
	return EntityStatus.new(max_health)

func _init(max_health: int) -> void:
	_max_health = max_health
	_health = max_health

func damage(amount: int) -> int:
	if (amount > 0):
		_health -= amount
		if (_health < 0):
			_health = 0
	return _health

func health() -> int:
	return _health
