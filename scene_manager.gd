extends Node

@export var enemies = []

@export var items = []

@export var spawnPoints: Array[Node] = [] 

#actual enemy objects
@export var enemyObjects: Array[Node2D] = [];

#actual itemObjects
@export var itemObjects: Array[Node2D] = [];

@export var enemyCounter := 0;

@export var levelsTillShop := 5;

@export var mask:Resource = load("res://Masks/L2.tres")

#enemies
const SLIME = preload("uid://cmxpb2t0xm3ss")
const SNOBLIN = preload("uid://dk62a48nf20jo")
const TROLL = preload("uid://c2q4u6cdbkkp8")

#items
const POTION_BLUE = preload("uid://b3esuv6g3uxw3")
const POTION_RED = preload("uid://irxnh1e4k85u")
const COIN = preload("uid://cuy1qmad8fikn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemyObjects = []
	itemObjects = []


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#print(enemies)


func getEnemiesFromName(names : Array):
	enemyCounter = names.size()
	enemyObjects.resize(names.size())
	for n in range(names.size()):
		if names[n] == "Slime":
			enemyObjects[n] = SLIME.instantiate()
			add_child(enemyObjects[n])
		
		elif names[n] == "Snoblin":
			enemyObjects[n] = SNOBLIN.instantiate()
			add_child(enemyObjects[n])
			
		elif names[n] == "Troll":
			enemyObjects[n] = TROLL.instantiate()
			add_child(enemyObjects[n])

#get the names of the items and convert them to actual items to send to the scene
func getItemsFromName(names: Array):
	itemObjects.resize(names.size())
	for n in range(names.size()):
		if names[n] == "BluePotion":
			itemObjects[n] = POTION_BLUE.instantiate()
			add_child(itemObjects[n])
			
		#update this to actual coin object	
		elif names[n] == "Coin":
			itemObjects[n] = COIN.instantiate()
			add_child(itemObjects[n])
		
		#update this to actual red potion 
		elif names[n] == "RedPotion":
			itemObjects[n] = POTION_RED.instantiate()
			add_child(itemObjects[n])
			#TODO: parent this to the actual level object
			
		elif names[n] == "Box":
			itemObjects[n] = POTION_RED.instantiate()
			add_child(itemObjects[n])
			#TODO: parent this to the actual level object
			
		elif names[n] == "Spike":
			itemObjects[n] = POTION_RED.instantiate()
			add_child(itemObjects[n])
			#TODO: parent this to the actual level object
			
		#Add all other items here

#TODO: figure out if we still use this
#func PopulateSpawnPoints(points: Array[Node] ):
#	spawnPoints = points.duplicate(false)
	
#func SpawnAll():
	#wait for all arrays to populate
#	await get_tree().create_timer(.2).timeout
#	getEnemiesFromName(enemies)
#	for n in range(enemyObjects.size()):
#		enemyObjects[n].global_position = spawnPoints[n].global_position
	
