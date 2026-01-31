extends CharacterBody2D

class_name Player

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D

@export var MAXSPEED := 55
const ACCELERATION := 5
const FRICTION := 8

@onready var playerSprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	var input = Vector2(
		Input.get_action_strength("x_right") - Input.get_action_strength("x_left"),
		Input.get_action_strength("y_down") - Input.get_action_strength("y_up"),
	).normalized()
	
	#can update this to handle the flip based on the character's mouse position
	if input.x > 0:
		animator.flip_h = false;
	elif input.x < 0: 
		animator.flip_h = true;
		
	if input.x != 0 || input.y != 0:
		animator.play("Walk")
	else:
		animator.play("Idle")
	
	var lerp_weight = delta * (ACCELERATION if input else FRICTION)
	velocity  = lerp(velocity, input * MAXSPEED, lerp_weight)

	move_and_slide()
	
	#look_at(get_global_mouse_position())
