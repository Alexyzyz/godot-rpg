extends Spatial

onready var camera = get_viewport().get_camera()
onready var battle_manager = get_parent()

const RAY_LENGTH = 100

var collided_node

func _physics_process(_delta):
	var space_state = get_world().direct_space_state
	var mouse_position = get_viewport().get_mouse_position()
	
	var from = camera.project_ray_origin(mouse_position)
	var to = from + camera.project_ray_normal(mouse_position) * RAY_LENGTH
	var intersection = space_state.intersect_ray(from, to)
	
	if !intersection.empty():
		collided_node = intersection.collider.get_parent().get_parent()
		
		OnHoverTile()
	else:
		collided_node = null

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and !event.pressed:
			 OnSelectTile()

# Custom functions

func OnHoverTile():
	if collided_node is TileController:
		var tile = collided_node
		tile.OnHover()

func OnHoverCard():
	if collided_node is TileController:
		var tile = collided_node
		tile.OnHover()

func OnSelectTile():
	if collided_node is TileController:
		var tile = collided_node
		battle_manager.SelectTile(tile)
