extends Node2D

@onready var PlayerRef : Player = $".."

var MouseActive = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MouseActive == true	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var joy_vector := Vector2(
		Input.get_joy_axis(0, JOY_AXIS_RIGHT_X),
		Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)
	)
	if abs(joy_vector.x) < 0.15:
		joy_vector.x = 0
	if abs(joy_vector.y) < 0.15:
		joy_vector.y = 0
	
	if (joy_vector.x*joy_vector.y!=0):
		if (MouseActive != false):
			MouseActive == false
		look_at(PlayerRef.position+joy_vector)
	elif (MouseActive == true):
		look_at(get_global_mouse_position())
