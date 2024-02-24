@tool
class_name VectorTool
extends Node2D

@export var hideInGame: bool = true

var _vector : Vector2
@export var vector := Vector2(100, 100) :
	set (value):
		_vector = value
		queue_redraw()
	get:
		return _vector

var _color : Color
@export var color := Color(255, 0, 0):
	set (value):
		_color = value
		queue_redraw()
	get:
		return _color

var vectorFrom := Vector2(0, 0)

const arrowAngle: float = PI / 6.0
const arrowToVecRatio: float = 6.0

func _draw() -> void:
	if (Engine.is_editor_hint() or !hideInGame) and vector:
		var effective_vector = vector
		var arrowLength: float = effective_vector.length() / arrowToVecRatio

		draw_line(vectorFrom, effective_vector, color, 0.5)
		var lineEnd = ((arrowLength) / effective_vector.length()) * effective_vector
		draw_line(effective_vector, effective_vector - lineEnd.rotated(-arrowAngle), color, 0.5)
		draw_line(effective_vector, effective_vector - lineEnd.rotated(arrowAngle), color, 0.5)
