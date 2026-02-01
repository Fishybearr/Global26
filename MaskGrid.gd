extends TileMapLayer

@export var noise: FastNoiseLite
# use tile data runtime update (coords vector2i)
# tile data runtime update
@export var background_tile_map : TileMapLayer
@export var SpriteResource : Mask
@export var MaskSprite : Sprite2D
var ReadyLookupTable: Array[Array]

#playerRef
@onready var player: Node2D = get_node("/root/Root/Player")

#this will be an array of levels we can pull from
#for now just using one level
var LEVEL_BASE = load("uid://bx4oqtrfc1pdc")


@onready var scene_manager: Node = get_node("/root/Root/SceneManager")


var tiles := [
	#other 1
	#enemies 2
	#Weapons 3
	
	#id,Vec2 coords in image,item type ^,name
	[Vector4i(0,6,2,1),"Spike"],
	[Vector4i(6,1,1,2),"Slime"],
	[Vector4i(6,1,1,2),"Troll"],
	[Vector4i(6,1,1,2),"Snoblin"],
	[Vector4i(7,0,0,1),"Coin"],
	[Vector4i(8,0,0,1),"BluePotion"],
	[Vector4i(9,0,0,1),"RedPotion"],
	[Vector4i(0,4,1,1),"Box"]
]

func SearchTiles(TileArray: Array,InputToCheck: Vector4i)->String:
	for i in len(TileArray):
		if TileArray[i][0] == InputToCheck:
			return TileArray[i][1]
	return "UNKNOWN"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Lookup Table init
	const SIZE = 9 # set size to 9
	for i in range(SIZE): # loop
		ReadyLookupTable.append([]) # Append an empty inner array (row)
		for j in range(SIZE):
			ReadyLookupTable[i].append(0) # Append a default value to the inner array
	
	#rng 
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	noise.seed=rng.randi()
	
	# loop through 9x9 grid
	for y in range(0, 9):
		for x in range(0, 9):
			# normalize and scale noise
			var maxVal: int = tiles.size()
			var out = (noise.get_noise_2d(x, y) + 1) / 2.0
			out *= maxVal
			var outInt : int = round(out)
			# set bg
			background_tile_map.set_cell(Vector2(x, y), 4, Vector2i.ZERO)
			set_cell(Vector2(x, y), tiles[outInt][0].x, Vector2i(tiles[outInt][0].y, tiles[outInt][0].z))
			# append to lookup table 
			ReadyLookupTable[x][y] = tiles[outInt][0]
	
	# Set Sprite crap
	MaskSprite.texture = SpriteResource.sprite
	Input.warp_mouse(Vector2(40*16,24*16))
	var mouseposition = local_to_map(get_local_mouse_position())
	MaskSprite.position = mouseposition*16


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var joy_vector := Vector2(
		Input.get_joy_axis(0, JOY_AXIS_RIGHT_X),
		Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)
	)
	var js_speed = 88
	# deadzones
	if abs(joy_vector.x) < 0.15:
		joy_vector.x = 0
	if abs(joy_vector.y) < 0.15:
		joy_vector.y = 0

	var actualmouseposition = get_local_mouse_position()

	actualmouseposition.x = actualmouseposition.x+joy_vector.x*js_speed
	actualmouseposition.y = actualmouseposition.y+joy_vector.y*js_speed    
	
	actualmouseposition.x = clamp(actualmouseposition.x,position.x,position.x+Vector2(8*16,8*16).x)
	actualmouseposition.y = clamp(actualmouseposition.y,position.y,position.y+Vector2(8*16,8*16).y)
	
	var PosBoundaryVec = Vector2(SpriteResource.selectionPosLength,SpriteResource.selectionPosHeight)
	var NegBoundaryVec = Vector2(SpriteResource.selectionNegLength,SpriteResource.selectionNegHeight)
	
	actualmouseposition.x = clamp(actualmouseposition.x,position.x,position.x+8*16-PosBoundaryVec.x*16)
	actualmouseposition.y = clamp(actualmouseposition.y,position.y,position.y+8*16-PosBoundaryVec.y*16)
	actualmouseposition.x = clamp(actualmouseposition.x,position.x+NegBoundaryVec.x*16,position.x+8*16)
	actualmouseposition.y = clamp(actualmouseposition.y,position.y+NegBoundaryVec.y*16,position.y+8*16)
	var mouseposition = local_to_map(actualmouseposition)
	
	MaskSprite.position = mouseposition*16
	if Input.is_action_just_pressed("Place"):
		var OutputOther = []
		var OutputEnemies = []
		var OutputWeapons = []
		for value in len(SpriteResource.offsets):
			var localcoords = mouseposition + SpriteResource.offsets[value]
			var LookupTableOutput = ReadyLookupTable[localcoords.x][localcoords.y]
			var cat = LookupTableOutput.w
			var OutputEntry = SearchTiles(tiles,LookupTableOutput)
			if cat == 1:
				OutputOther.append(OutputEntry)
			elif cat == 2:
				OutputEnemies.append(OutputEntry)
			elif cat == 3:
				OutputWeapons.append(OutputEntry)
		print(OutputOther)
		print(OutputEnemies)
		print(OutputWeapons)
		
		#this is where we load the next scene and send data to other objects
		
		#load the scene manager with the string arrays
		scene_manager.getEnemiesFromName(OutputEnemies)
		
		scene_manager.getItemsFromName(OutputOther)
		
		#create new scene
		var lb = LEVEL_BASE.instantiate()
		get_node("/root/Root/SceneManager").add_child(lb)
		player.playerActive = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_node("/root/Root/SceneManager/Node2D").queue_free()
		print("base")
		
		
		
