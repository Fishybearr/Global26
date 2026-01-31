extends TileMapLayer

@export var noise: FastNoiseLite

var tiles := [
	Vector3i(0, 6, 2),
	Vector3i(6,1,1),
	Vector3i(7,0,0),
	Vector3i(8,0,0),
	Vector3i(9,0,0),
	Vector3i(10,0,1)
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	noise.seed=rng.randi()
	
	for y in range(0, 5):
		for x in range(0, 5):
			const maxVal: int = 20
			var out = (noise.get_noise_2d(x, y) + 1) / 2.0
			out *= maxVal
			
			var outInt : int = floor(out)
			
			set_cell(Vector2(x, y), tiles[0].x, Vector2i(tiles[0].y, tiles[0].z))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
