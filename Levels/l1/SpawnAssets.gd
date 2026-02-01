extends Node

@onready var scene_manager: Node = get_node("/root/Root/SceneManager")

@export var spawnRef : Node
@export var itemRef : Node

var SpawnPoints : Array[Node2D]
var ItemSpawns : Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SetEnemyPos()
	SetItemPos()
	for child in spawnRef.get_children():
		SpawnPoints.push_back(child)
	
	for child in itemRef.get_children():
		ItemSpawns.push_back(child)
	
func SetEnemyPos():
	await get_tree().create_timer(.05).timeout
	for i in range(scene_manager.enemyObjects.size()):
		
		scene_manager.enemyObjects[i].global_position = SpawnPoints[i].global_position
		
func SetItemPos():
	await get_tree().create_timer(.05).timeout
	for i in range(scene_manager.itemObjects.size()):
		
		scene_manager.itemObjects[i].global_position = ItemSpawns[i].global_position
