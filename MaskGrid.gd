extends TileMapLayer

@export var noise: FastNoiseLite
# use tile data runtime update (coords vector2i)
# tile data runtime update
@export var background_tile_map : TileMapLayer
@export var SpriteResource : Mask
@export var MaskSprite : Sprite2D


var tiles := [
	Vector3i(0,6,2),
	Vector3i(6,1,1),
	Vector3i(7,0,0),
	Vector3i(8,0,0),
	Vector3i(9,0,0),
	Vector3i(10,0,1),
	Vector3i(0,4,1)
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	noise.seed=rng.randi()
	
	for y in range(0, 9):
		for x in range(0, 9):
			var maxVal: int = tiles.size()
			var out = (noise.get_noise_2d(x, y) + 1) / 2.0
			out *= maxVal
			var outInt : int = round(out)
			background_tile_map.set_cell(Vector2(x, y), 4, Vector2i.ZERO)
			set_cell(Vector2(x, y), tiles[outInt].x, Vector2i(tiles[outInt].y, tiles[outInt].z))
	
	MaskSprite.texture = SpriteResource.sprite
	var mouseposition = local_to_map(get_local_mouse_position())
	MaskSprite.position = mouseposition*16


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouseposition = local_to_map(get_local_mouse_position())
	MaskSprite.position = mouseposition*16
	if Input.is_action_just_pressed("Place"):
		for value in len(SpriteResource.offsets):
			print(value)
		
