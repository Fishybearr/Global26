extends Area2D

@onready var gun: Sprite2D = $"../../Player/StaticBody2D/GunPoint"

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animator.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#currently no timer on this, just adds it
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("got potion")
		gun.gun_damage += 10
		queue_free()
