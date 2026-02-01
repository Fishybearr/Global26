extends Area2D

@onready var player: Player = get_node("/root/Root/Player")

var SHOP_MENU = load("uid://bwd20fk3b2cy0")
@onready var scene_manager: Node = get_node("/root/Root/SceneManager")

@onready var ui: CanvasLayer = get_node("/root/Root/CanvasLayer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player && scene_manager.enemyCounter <= 0:
		player.playerActive = false
		var shop = SHOP_MENU.instantiate();
		ui.add_child(shop)
