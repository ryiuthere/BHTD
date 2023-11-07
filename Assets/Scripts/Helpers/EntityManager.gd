class_name EntityManager

var _enemies : Array[Enemy] = []

func create_enemy(enemy : Constants.Enemy, position : Vector2) -> Enemy:
	var instance = Loader.load_enemy(enemy)
	instance.position = position
	_enemies.append(instance)
	GameController.get_tree().current_scene.add_child(instance)
	return instance

func closest_enemy(position : Vector2, max_distance : int) -> Enemy:
	var closest_enemy = null
	var closest_distance = -1
	for enemy in _enemies:
		var distance = position.distance_to(enemy.position)
		if  (distance < closest_distance or closest_enemy == null) and distance < max_distance:
			closest_distance = distance
			closest_enemy = enemy
	return closest_enemy

func create_projectile(projectile : Constants.Projectile, position : Vector2, direction : Vector2) -> Projectile:
	var instance = Loader.load_projectile(projectile)
	instance.initialize(position, direction)
	GameController.get_tree().current_scene.add_child(instance)
	return instance
	
