class_name BasicBehaviour extends Behaviour

const _distance := 300

func act(enemy: Enemy, _delta: float) -> void:
	var to_player = (GameController.current_hero.position - enemy.position)
	if to_player.length() < _distance:
		enemy.set_direction(to_player)
	else:
		enemy.set_direction(GameController.chest.position - enemy.position)
