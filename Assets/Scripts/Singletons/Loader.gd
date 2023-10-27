extends Node

func load_hero(hero: Constants.Hero) -> Hero:
	match(hero):
		Constants.Hero.Mage:
			return load(Constants.HEROES_PATH + "Mage.tscn").instantiate() as Hero
		_:
			return null

func load_chest() -> Chest:
	return load(Constants.INTERACTABLES_PATH + "Chest.tscn").instantiate() as Chest
