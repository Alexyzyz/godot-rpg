extends Control

class_name CardController

onready var battle_manager = get_node('/root/Level/BattleManager')
onready var card_info_ui = get_node("/root/Level/GUI/CardInfo")

onready var tween = $Tween

var title: String
var desc: String = (
	'Walk\n' +
	'Moves this unit to another tile.'
)

var ap_cost: int
var mp_cost: int

var initial_position: Vector2
var initial_rotation: float

var is_hovered: bool
var is_selected: bool
var hover_anim_dist: float = 40

var position: Vector2
var target_position: Vector2

func _ready():
	initial_position = Vector2(self.margin_left, self.margin_top)

func init(title, desc, ap_cost, mp_cost):
	self.title = title

func get_title():
	return self.title

func _process(_delta):
	Animate()

func _gui_input(event):
	if event is InputEventMouse and event.is_pressed():
		ToggleSelect(!is_selected)

# Signals
	
func _on_Card_mouse_entered():
	is_hovered = true

func _on_Card_mouse_exited():
	is_hovered = false

# Custom functions

func ToggleSelect(toggle: bool):
	is_selected = toggle
	if is_selected:
		battle_manager.selected_card = self
		card_info_ui.SetText(desc)
	else:
		battle_manager.selected_card = null
		card_info_ui.SetText('')

func Animate():
	if !(is_hovered or is_selected):
		target_position = initial_position
	else:
		target_position = (
			initial_position + hover_anim_dist * Vector2(0, -1)
		)
	tween.interpolate_property(
		self,
		"position",
		position,
		target_position,
		0.2,
		tween.TRANS_SINE,
		tween.TRANS_SINE
	)
	tween.start()
	self.margin_left = position.x
	self.margin_top = position.y
	self.margin_bottom = position.y + 140
