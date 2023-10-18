extends entity

# Called when the node enters the scene tree for the first time.
func _ready():
	var sprite := $Sprite2D as Sprite2D
	sprite.modulate = Color.RED;
