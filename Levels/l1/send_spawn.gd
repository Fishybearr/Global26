extends Node

#get ref to the SceneManager
#@onready var scene_manager: Node = get_node("/root/Root/SceneManager")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#scene_manager.PopulateSpawnPoints(get_children())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#TODO: Need to redo the whole scene loading system
# need to load the selector scene first
# then load the game scene, then load selector again from that
