class_name Hero extends Entity

func set_current() -> void:
	GameController.set_camera_focus(self)
