extends Node

var entity_manager : EntityManager = EntityManager.new()

var default_hero := Constants.Hero.Mage
var chest : Chest
var current_hero : Hero

var _camera : Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Turn on input detection for released keys
	set_process_input(true)
	
	var _main_root = get_tree().current_scene
	_camera = Camera2D.new()
	_main_root.add_child(_camera)
	if (!_camera.is_current()):
		_camera.enabled = true
		_camera.make_current()
	
	# Temporary set up
	chest = Loader.load_chest()
	_main_root.add_child(chest)
	
	current_hero = Loader.load_hero(default_hero)
	current_hero.position.x += 50
	current_hero.set_current()
	_main_root.add_child(current_hero)
	
	entity_manager.create_enemy(Constants.Enemy.TempEvilMage, Vector2(-300,0))
	entity_manager.create_enemy(Constants.Enemy.TempEvilMage, Vector2(700,100))

func set_camera_focus(node: Node) -> void:
	var old_parent = _camera.get_parent()
	if old_parent:
		old_parent.remove_child(_camera)
	node.add_child(_camera)

func _input(event: InputEvent) -> void:
	InputManager.HandleInput(event)

func set_player_direction(direction: Vector2) -> void:
	current_hero.set_direction(direction)

func quit_game() -> void:
	get_tree().quit()
