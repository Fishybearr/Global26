extends Area2D

@onready var player: Player = get_node("/root/Root/Player")

@onready var level: Node2D = $".."

var MOUSESCENE = load("uid://bpwrehfeq5xf2")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("next level") 
		print(MOUSESCENE)
		var ms = MOUSESCENE.instantiate()
		get_node("/root/Root/SceneManager").add_child(ms)
		player.playerActive = false
		
		get_node("/root/Root/SceneManager/LevelBase").queue_free()
		

		
		#player.playerActive = false
		
		#get_tree().change_scene_to_file("res://mousescene.tscn")
		#level.queue_free()
