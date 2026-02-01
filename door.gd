extends Area2D

@onready var player: Player = get_node("/root/Root/Player")

@onready var scene_manager: Node = get_node("/root/Root/SceneManager")

@onready var camera_2d: Camera2D = get_node("/root/Root/Camera2D")

@onready var level: Node2D = $".."

var MOUSESCENE = load("uid://bpwrehfeq5xf2")

#level script we use to hold the enemyCounter
@onready var level_base: Node = $"../.."

func _on_body_entered(body: Node2D) -> void:
	if body is Player && scene_manager.enemyCounter <= 0:
		print("next level") 
		
		
		for i in scene_manager.itemObjects:
			if is_instance_valid(i):
				i.queue_free();
			
		print(MOUSESCENE)
		var ms = MOUSESCENE.instantiate()
		get_node("/root/Root/SceneManager").add_child(ms)
		player.playerActive = false
		get_node("/root/Root/CanvasLayer").visible = false
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

		camera_2d.zoom = Vector2(5,5)
		camera_2d.global_position = Vector2(0,0)
		var l = get_node("/root/Root/SceneManager/LevelBase")
		if l == null:
			var l2 = get_node("/root/Root/SceneManager/LevelBase2")
			l2.queue_free()
			await l2.tree_exited
			camera_2d.global_position = Vector2.ZERO
		else:
			l.queue_free()
			await l.tree_exited
			camera_2d.global_position = Vector2.ZERO
			
		

		
		#player.playerActive = false
		
		#get_tree().change_scene_to_file("res://mousescene.tscn")
		#level.queue_free()
