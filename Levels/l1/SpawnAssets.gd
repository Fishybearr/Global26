extends Node

@onready var scene_manager: Node = get_node("/root/Root/SceneManager")


@export var SpawnPoints: Array[Node]

@export var ItemSpawns: Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SetEnemyPos()
	SetItemPos()
	#this will set the positions of the actual enemy objects after they've been created by SceneMange
	
		
		#populate each spawn


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func SetEnemyPos():
	await get_tree().create_timer(.05).timeout
	for i in range(scene_manager.enemyObjects.size()):
		
		scene_manager.enemyObjects[i].global_position = SpawnPoints[i].global_position
		
func SetItemPos():
	await get_tree().create_timer(.05).timeout
	for i in range(scene_manager.itemObjects.size()):
		
		scene_manager.itemObjects[i].global_position = ItemSpawns[i].global_position
