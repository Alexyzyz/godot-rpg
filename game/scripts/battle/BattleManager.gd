extends Spatial

class_name BattleManager

onready var rng = RandomNumberGenerator.new()

onready var Unit: PackedScene = preload("res://prefabs/Unit.tscn")

onready var unit_parent = get_node("/root/Level/Parents/UnitParent")
onready var card_parent = get_node("/root/Level/CardParent")
onready var tile_info_ui = get_node("/root/Level/GUI/TileInfo")

onready var arena_manager = $ArenaManager
onready var audio_player = $AudioStreamPlayer

# more than one party may compete to win
var party_count = 2
var party_turn = 0

var unit_list = []
var show_cards: bool = false

var selected_tile: TileController
var selected_unit: UnitController
var selected_card: CardController

var tile_map = []

func _ready():
	rng.randomize()
	audio_player.play()
	
	print(Global.unit_deck[0].title)
	
	tile_map = arena_manager.GenerateTiles(9)
	InitializeUnits()

# Custom functions

func InitializeUnits():
	var unit = Unit.instance()
	unit_parent.add_child(unit)
	unit_list.append(unit)
	
	unit.party_index = 0
	selected_unit = unit
	
	var rand_tile: TileController = tile_map[4][4]
	rand_tile.occupying_unit = selected_unit
	selected_unit.MoveToTile(rand_tile)

func SelectTile(tile: TileController):
	# deselect the current tile
	if tile == selected_tile:
		ToggleSelectTile(tile, false)
		card_parent.ToggleVisible(false)
		return
		
	ToggleSelectTile(selected_tile, false)
	ToggleSelectTile(tile, true)
	
	# check for its occupying unit
	var tile_unit = tile.occupying_unit
	if tile_unit == null:
		if selected_card != null and selected_unit != null:
			selected_unit.MoveToTile(tile)
			selected_card.is_selected = false
			PlayCard()
		selected_unit = null
		card_parent.ToggleVisible(false)
	else:
		card_parent.ToggleVisible(tile_unit.party_index == party_turn)
		selected_unit = tile_unit
	
	var message_prefix = ''
	if selected_tile != null:
		if tile.occupying_unit != null:
			message_prefix = "There's a unit here "
		else:
			message_prefix = "There is no unit here "
		tile_info_ui.SetText(message_prefix + "(%s, %s)" % [tile.x, tile.z])
	else:
		tile_info_ui.SetText('')

func ToggleSelectTile(tile: TileController, toggle: bool):
	if tile == null:
		return
	tile.is_selected = toggle
	selected_tile = tile if toggle else null

func PlayCard():
	selected_card.ToggleSelect(false)
	selected_card = null
	ToggleSelectTile(selected_tile, false)
