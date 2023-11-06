class_name Mage extends Hero

# Called when the node enters the scene tree for the first time.
func _ready():
	_base_speed = 20

func _process(delta):
	$Sprite.play()
	if velocity.x != 0:
		$Sprite.animation = "Walk"
		$Sprite.flip_h = velocity.x < 0
	else:
		$Sprite.animation = "Idle"
