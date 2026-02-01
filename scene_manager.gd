extends Node

@export var enemies = []

@export var items = []

@export var spawnPoints: Array[Node] = [] 

#actual enemy objects
@export var enemyObjects: Array[Node2D] = [];

const SLIME = preload("uid://cmxpb2t0xm3ss")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#print(enemies)


func getEnemiesFromName(names : Array):
	enemyObjects.resize(names.size())
	for n in range(names.size()):
		if names[n] == "Slime":
			enemyObjects[n] = SLIME.instantiate()
			get_tree().root.add_child(enemyObjects[n])

#TOOD: Update this to do the enemty counting as wells

func PopulateSpawnPoints(points: Array[Node] ):
	spawnPoints = points.duplicate(false)
	
func SpawnAll():
	#wait for all arrays to populate
	await get_tree().create_timer(.2).timeout
	getEnemiesFromName(enemies)
	for n in range(enemyObjects.size()):
		enemyObjects[n].global_position = spawnPoints[n].global_position
	
