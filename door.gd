extends Area2D

@onready var player: Player = get_node("/root/Root/Player")

@onready var level: Node2D = $".."
const MOUSESCENE = preload("uid://bpwrehfeq5xf2")


#@onready var spawn_manager: Node = $"../SpawnManager"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("next level") 
		var ms = MOUSESCENE.instantiate()
		
		player.playerActive = false
		
		get_node("/root/Root").add_child(ms)
		#level.queue_free()
