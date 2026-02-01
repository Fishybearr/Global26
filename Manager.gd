extends Node2D

#const level = preload("res://Levels/l1/new_level.tscn")
const selection = preload("res://mousescene.tscn")

@onready var camera_2d: Camera2D = get_node("/root/Root/Camera2D")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera_2d.zoom = Vector2(5,5)
	$SceneManager.add_child(selection.instantiate())
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
