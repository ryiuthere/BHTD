extends Enemy

func _ready() -> void:
	_behaviour = BasicEnemyBehaviour.new()
	_base_speed = 9
