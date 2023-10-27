class_name BasicBehaviour

func get_direction(current_position, target_position) -> Vector2:
	return (target_position - current_position).normalized()
	
