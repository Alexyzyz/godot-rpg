extends Spatial

class_name UnitController

onready var camera = get_node("/root/Level/Camera/Cam")
onready var battle_manager = get_node("/root/Level/BattleManaer")

var tile_x: int
var tile_z: int

var health: int = 10000
var max_sp: int = 10
var max_mp: int = 20
var sp: int = 10
var mp: int = 20

# the party this unit belongs to
var party_index = 0

var nickname: String

var occupying_tile: TileController

var hand = []
var draw_pile = []
var discard_pile = []

func init(nickname: String, tile: TileController):
	self.nickname = nickname
	MoveToTile(tile)

# Custom functions

func MoveToTile(tile: TileController):
	tile_x = tile.x
	tile_z = tile.z
	self.transform.origin = tile.transform.origin
	
	if occupying_tile != null:
		occupying_tile.occupying_unit = null
	occupying_tile = tile
	tile.occupying_unit = self

func LookAtCamera():
	var look_at_position = camera.global_transform.origin
	look_at_position.y = 0
	self.look_at(look_at_position, Vector3.UP)
