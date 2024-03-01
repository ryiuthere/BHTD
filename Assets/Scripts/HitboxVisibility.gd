@tool
extends CollisionShape2D

@export var enable : bool:
	get:
		return !disabled
	set(value):
		disabled = !value
		visible = value
