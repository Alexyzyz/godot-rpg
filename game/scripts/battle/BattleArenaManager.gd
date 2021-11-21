extends Spatial

var rng = RandomNumberGenerator.new()

onready var Tile: PackedScene = preload("res://prefabs/Tile.tscn")

onready var tile_parent = get_node('/root/Level/Parents/TileParent')

const TILE_WIDTH = 6
const TILE_PADDING_RATIO = 0.13397459621

# Custom functions

func GenerateTiles(radius: int):
	var tile_map = []
	for z in range(radius):
		var tile_row = []
		for x in range(radius):
			var centered_x = x - radius / 2
			var centered_z = z - radius / 2
			
			if sqrt(pow(centered_x, 2) + pow(centered_z, 2)) > radius / 2:
				continue
			
			var tile = Tile.instance()
			tile_parent.add_child(tile)
			tile_row.append(tile)
			
			tile.x = x
			tile.z = z
			
			var tile_width_padding = TILE_WIDTH * TILE_PADDING_RATIO
			var tile_height_padding = TILE_WIDTH / 4.0
			var x_offset = 0.5 * (TILE_WIDTH - tile_width_padding) if z % 2 == 0 else 0
			
			var tile_position = Vector3(
				(TILE_WIDTH - tile_width_padding) * x + x_offset,
				0,
				(TILE_WIDTH - tile_height_padding) * z
			)
			tile.transform.origin = tile_position
		tile_map.append(tile_row)
	return tile_map
