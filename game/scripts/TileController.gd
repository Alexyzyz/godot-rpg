extends Spatial

class_name TileController

onready var rng = RandomNumberGenerator.new()

onready var mesh = $HexagonMesh

var x: int
var z: int
var occupying_unit

var initial_color: Color
var is_hovered = false
var is_selected = false

func _ready():
	rng.randomize()
	
	initial_color = Color(
		0.4,
		0.5,
		0.5,
		1.0
	)
	
	var material = SpatialMaterial.new()
	material.albedo_color = initial_color
	mesh.material_override = material

func _process(_delta):
	HandleHovered()

# Custom functions

func HandleHovered():
	var hovered_color = initial_color + Color(0.1, 0.1, 0.1, 1.0)
	mesh.material_override.albedo_color = (
		initial_color if (is_hovered == false and is_selected == false) else
		hovered_color
	)
	is_hovered = false

func OnHover():
	is_hovered = true

func GenerateWarmColor(min_rgb: float):
	var remaining_rgb = 1 - min_rgb
	
	var rand_r = rng.randf_range(0, remaining_rgb)
	remaining_rgb -= rand_r
	var rand_g = rng.randf_range(0, remaining_rgb)
	remaining_rgb -= rand_g
	var rand_b = remaining_rgb
	
	return Color(
		rand_r + min_rgb,
		rand_g + min_rgb,
		rand_b + min_rgb,
		1.0
	)
