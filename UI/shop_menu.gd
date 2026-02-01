extends Control

@onready var player: Player = get_node("/root/Root/Player")

@export var masks:Array[Resource]

@onready var scene_manager: Node = get_node("/root/Root/SceneManager")

var MOUSESCENE = load("uid://bpwrehfeq5xf2")

@onready var camera_2d: Camera2D = get_node("/root/Root/Camera2D")

var oldPos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	oldPos = player.global_position
	oldPos = Vector2(oldPos.x,oldPos.y + 50)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_buttonL_pressed() -> void:
	if player.coins >= 5:
		print("bought")
		player.coins -= 5
		
		scene_manager.mask = masks.pick_random()
		player.playerActive = true
		player.global_position = oldPos
		queue_free()
	else:
		print("no money")
		
	#LoadNextLevel()


func _on_buttonM_pressed() -> void:
	if player.coins >= 5:
		print("bought")
		player.coins -= 5
		
		scene_manager.mask = masks[10]
		player.playerActive = true
		player.global_position = oldPos
		queue_free()
	else:
		print("no money")
	
	#LoadNextLevel()


func _on_buttonR_pressed() -> void:
	if player.coins >= 5:
		print("bought")
		player.coins -= 5
		
		#set the mask in SceneManager and then set that when we load the selection scene
		scene_manager.mask =  masks.pick_random()
		player.playerActive = true
		player.global_position = oldPos
		queue_free()
	else:
		print("no money")
		#player.playerActive = true
		#player.global_position = oldPos
		#queue_free()
		
		
func LoadNextLevel():
	
	for i in scene_manager.itemObjects:
		if is_instance_valid(i):
			i.queue_free();
			
	
	var ms = MOUSESCENE.instantiate()
	get_node("/root/Root/SceneManager").add_child(ms)
	#ms.global_position = Vector2(0,0)
	player.playerActive = false
	get_node("/root/Root/CanvasLayer").visible = false
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
#LoadNextLevel()
	camera_2d.zoom = Vector2(5,5)
	camera_2d.global_position = Vector2(0,0)
	var l = get_node("/root/Root/SceneManager/LevelBase")
	if l == null:
		get_node("/root/Root/SceneManager/LevelBase2").queue_free()
	else:
		l.queue_free()
		await l.tree_exited
		camera_2d.global_position = Vector2.ZERO


func _on_close_button_pressed() -> void:
	player.playerActive = true
	player.global_position = oldPos
	queue_free()
