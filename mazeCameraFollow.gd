extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await get_tree().physics_frame
	get_node("/root/Root/Camera2D").position = get_node("/root/Root/Player").position
	pass
