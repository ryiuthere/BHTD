extends Node

var hitboxes : Array
var hurtboxes : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Hitbox:
			child.collider.set_disabled(true)
			hitboxes.append(child)
		elif child is Hurtbox:
			child.collider.set_disabled(true)
			hitboxes.append(child)

func cleanup() -> void:
	pass

func _on_hitbox_area_entered(area):
	pass # Replace with function body.

func _on_hurtbox_area_entered(area):
	pass # Replace with function body.
