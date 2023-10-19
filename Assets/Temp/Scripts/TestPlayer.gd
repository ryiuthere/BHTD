extends entity

@export var enemies : Array[CharacterBody2D] = []

const detectionRadius = 200;

func _ready():
	moveSpeed = 200

func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * moveSpeed

func _physics_process(_delta):
	get_input()
	super(_delta)

func _draw():
	var closest = null
	var distanceToClosest = detectionRadius + 1;
	for e in enemies:
		var distanceToEnemy = position.distance_to(e.position)
		if (closest == null || distanceToEnemy < distanceToClosest):
			closest = e
			distanceToClosest = distanceToEnemy
	if distanceToClosest < detectionRadius:
		print(closest.name + ", distance: " + str(distanceToClosest).pad_decimals(2))
		draw_line(position - global_position, closest.position - global_position, Color.SKY_BLUE)

func _process(_delta):
	queue_redraw()
