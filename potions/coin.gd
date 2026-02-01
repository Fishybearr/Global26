extends Area2D

@onready var player: Node2D = get_node("/root/Root/Player")

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
		player.coins += 1;
		queue_free()
