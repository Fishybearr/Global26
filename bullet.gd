extends RigidBody2D

var bulletDamage := 1;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	



func _on_body_entered(body: Node) -> void:
	if body is Enemy:
		body.health -= bulletDamage;
		var tween = get_tree().create_tween()

		# Flash to white (or any color) instantly
		body.modulate = Color.RED 
		
		# Tween back to normal white (1,1,1,1) over 0.2 seconds
		tween.tween_property(body, "modulate", Color.WHITE, 0.2)
		#print(bulletDamage)
	queue_free()
