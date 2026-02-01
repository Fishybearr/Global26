extends Control

@onready var player: Player = get_node("/root/Root/Player")

@export var masks:Array[Resource]

@onready var scene_manager: Node = get_node("/root/Root/SceneManager")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_buttonL_pressed() -> void:
	if player.coins >= 5:
		print("bought")
		player.coins -= 5
		
		scene_manager.mask = masks[2]
		player.playerActive = true
		player.global_position = Vector2(100,100)
		queue_free()
	else:
		print("no money")


func _on_buttonM_pressed() -> void:
	if player.coins >= 5:
		print("bought")
		player.coins -= 5
		
		scene_manager.mask = masks[4]
		player.playerActive = true
		player.global_position = Vector2(100,100)
		queue_free()
	else:
		print("no money")


func _on_buttonR_pressed() -> void:
	if player.coins >= 5:
		print("bought")
		player.coins -= 5
		
		#set the mask in SceneManager and then set that when we load the selection scene
		scene_manager.mask = masks[0]
		player.playerActive = true
		player.global_position = Vector2(100,100)
		queue_free()
	else:
		print("no money")
