class_name InputManager

static func HandleInput(event: InputEvent) -> void:
	if (event.is_action_pressed("Menu")):
		GameController.quit_game()
	
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down").normalized()
	GameController.set_player_direction(input_direction)
