extends CharacterBody2D

class_name Player

@export var MAXSPEED := 55
const ACCELERATION := 5
const FRICTION := 8


func _physics_process(delta: float) -> void:
	var input = Vector2(
		Input.get_action_strength("x_right") - Input.get_action_strength("x_left"),
		Input.get_action_strength("y_down") - Input.get_action_strength("y_up"),
	).normalized()
	
	var lerp_weight = delta * (ACCELERATION if input else FRICTION)
	velocity  = lerp(velocity, input * MAXSPEED, lerp_weight)

	move_and_slide()
	
	#attack handling
	if Input.is_action_just_pressed("hit_attack"):
		HitAttack()
	
# TODO: add a cooldown to the hit attack	
func HitAttack():
	print("attack")
