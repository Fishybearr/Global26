extends Node2D

@onready var PlayerRef : Player = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var joy_vector := Vector2(
		Input.get_joy_axis(0, JOY_AXIS_RIGHT_X),
		Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)
	)
	if (joy_vector.x*joy_vector.y!=0):
		look_at(PlayerRef.position+joy_vector)
	else:
		look_at(get_global_mouse_position())
