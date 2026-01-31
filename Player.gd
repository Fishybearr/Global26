extends CharacterBody2D

class_name Player

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D

@export var MAXSPEED := 55

@onready var player_health_bar: TextureProgressBar = $"../PlayerHealthBar"

@export var health := 100
const ACCELERATION := 5
const FRICTION := 8

func _physics_process(delta: float) -> void:
	player_health_bar.value = health
	
	#WARNING: THIS WILL CRASH THE GAME IF THE PLAYER DIES
	#use this to trigger gameover instead of destroying object
	if health <= 0:
		queue_free()
	
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


func _on_door_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
