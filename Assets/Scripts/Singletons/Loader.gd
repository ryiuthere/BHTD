extends Node

func load_hero(hero: Constants.Hero) -> Hero:
	match(hero):
		Constants.Hero.Mage:
			return load(Constants.HEROES_PATH + "Mage.tscn").instantiate() as Hero
		_:
			return null

func load_enemy(enemy: Constants.Enemy) -> Enemy:
	match(enemy):
		Constants.Enemy.TempEvilMage:
			return load(Constants.ENEMIES_PATH + "TempEvilMage.tscn").instantiate() as Enemy
		_:
			return null

func load_projectile(projectile: Constants.Projectile) -> Projectile:
	match(projectile):
		Constants.Projectile.TempProjectile:
			return load(Constants.PROJECTILES_PATH + "TempProjectile.tscn").instantiate() as Projectile
		_:
			return null

func load_chest() -> Chest:
	return load(Constants.INTERACTABLES_PATH + "Chest.tscn").instantiate() as Chest
