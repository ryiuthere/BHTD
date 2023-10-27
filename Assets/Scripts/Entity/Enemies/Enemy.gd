class_name Enemy extends Entity

var _behaviour : Behaviour

func _ready() -> void:
	_behaviour = BasicBehaviour.new()
	_base_speed = 10

# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	_behaviour.act(self, delta)
	super(delta)
