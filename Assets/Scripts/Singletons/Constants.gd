extends Node

var BASE_ASSETS_PATH = "res://Assets/"
var HEROES_PATH = BASE_ASSETS_PATH + "Scenes/Entities/Heroes/"
var ENEMIES_PATH = BASE_ASSETS_PATH + "Scenes/Entities/Enemies/"
var INTERACTABLES_PATH = BASE_ASSETS_PATH + "Scenes/Entities/Interactables/"
var PROJECTILES_PATH = BASE_ASSETS_PATH + "Scenes/Entities/Projectiles/"

enum Condition {
	OK
}

enum Hero {
	Mage
}

enum Enemy {
	TempEvilMage
}

enum Projectile {
	TempProjectile
}

enum Collision {
	Hero = 0,
	Enemy = 1,
	HeroProjectile = 2,
	EnemyProjectile = 3,
	Interactable = 4,
	Map = 5
}
