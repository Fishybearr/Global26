extends CharacterBody2D

class_name Enemy

@export var health := 100;

@export var movement_speed = 5000;


#get ref to player
@onready var player: Player = $"../Player"

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D

@export var can_attack = true;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#disable collisions with player
	add_collision_exception_with(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$NavigationAgent2D.target_position = player.global_position
	
#TODO: check when near player, if close enough, then we should run attack anim on a timer
# at a random interval
func _physics_process(delta: float) -> void:
	
	
	#if player's within like 60 we can attack
	#print(global_position.distance_to(player.global_position))
	if global_position.distance_to(player.global_position) < 60 && can_attack == true:
		attackPlayer()
	
	if health  <= 0:
		queue_free()
		
	if !$NavigationAgent2D.is_target_reached():
		var nav_point_direction = to_local($NavigationAgent2D.get_next_path_position()).normalized()
		velocity = nav_point_direction * movement_speed* delta
		move_and_slide()
		
		if velocity.x > 0:
			animator.flip_h = false;
		
		else:
			animator.flip_h = true;


func _on_timer_timeout() -> void:
	if $NavigationAgent2D.target_position != player.global_position:
		$NavigationAgent2D.target_position = player.global_position
	$PathfindingUpdateTimer.start()
	
func attackPlayer():
	can_attack = false;
	print("attacking")
	attackAnim()
	player.health -= 10
	await get_tree().create_timer(2).timeout
	can_attack = true;
	
func attackAnim():
	animator.play("Attack")
	await animator.animation_finished
	animator.play("Idle")
	
