extends Node

#might need to make this a node2d array
@export var enemies: Array[Node2D]

@export var items: Array[Node]

@export var spawnPoints: Array[Node2D]

@export var enemyCount := -1;

var can_open = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#call spawn on startup for now
	Spawn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#check to see if all enemies are dead
	if enemyCount <= 0:
		can_open = true
		
	if can_open == true:
		OpenDoor()
		can_open = false;
	

func Spawn():
	#get number of enemies for level end counter
	enemyCount = enemies.size()
	
	for i in range(enemyCount):
		enemies[i].global_position = spawnPoints[i].global_position
	
	#spawn all items at the spawn points

# open the door
func OpenDoor():
	print("Door Open")
