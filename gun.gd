extends Sprite2D

const bullet: PackedScene = preload("res://bullet.tscn")

@export var bullet_force := 50000.0;

@export var can_shoot := true;

@export var bullet_delay:= 0.2;

@export var gun_damage := 10;

@onready var player: Player = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	#set a timer here for shooting cooldown
	if player.playerActive:
		if Input.is_action_just_pressed("hit_attack") && can_shoot:
			#print("shhoting");
			ShootDelay()
			$AudioStreamPlayer.play()
			var bulletInstance = bullet.instantiate();
			bulletInstance.global_position = global_position
			bulletInstance.global_rotation = global_rotation
			bulletInstance.apply_central_force(bullet_force * Vector2.from_angle(global_rotation))
			get_tree().get_root().add_child(bulletInstance)
			bulletInstance.bulletDamage = gun_damage;
		
		
func ShootDelay():
	can_shoot = false
	await get_tree().create_timer(bullet_delay).timeout
	can_shoot = true
	
