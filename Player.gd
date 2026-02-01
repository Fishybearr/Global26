extends CharacterBody2D

class_name Player

@export var playerActive = true;

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D

@export var MAXSPEED := 55

@onready var player_health_bar: TextureProgressBar = $"../PlayerHealthBar"

@onready var coin_count: Label = $"../CoinCount"

@export var coins := 0;

@export var health := 100
const ACCELERATION := 5
const FRICTION := 8

func _physics_process(delta: float) -> void:
	coin_count.text = str(coins)
	
	player_health_bar.value = health
	
	#WARNING: THIS WILL CRASH THE GAME IF THE PLAYER DIES
	#use this to trigger gameover instead of destroying object
	if health <= 0:
		get_tree().change_scene_to_file.call_deferred("res://UI/DeathScreen.tscn")
	
	if playerActive:
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
	else:
		position = Vector2(-1000,-1000)
		velocity = Vector2.ZERO
	
	#look_at(get_global_mouse_position())

func _exit_tree() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://UI/DeathScreen.tscn")

func _on_door_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_potion_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
