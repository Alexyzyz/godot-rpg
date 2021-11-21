extends Spatial

onready var rig = get_parent()
onready var tween = $Tween

const MOVE_SENSITIVITY = 0.5
const ZOOM_SENSITIVITY = 2
const ZOOM_DURATION = 0.2

const MIN_Y_ANGLE = PI / 32
const MAX_Y_ANGLE = PI / 2 - PI / 32
const MIN_DIST = 5
const MAX_DIST = 25

var dist: float = 5
var target_dist: float = 5

var is_dragging: bool = false
var x_angle: float = 0
var y_angle: float = PI / 4

var delta: float

func _process(process_delta):
	delta = process_delta
	
	HandleCameraMovement()

func _input(event):
	if is_dragging and event is InputEventMouseMotion:
		UpdateCameraAngles(event.relative)

func _unhandled_input(event):
	if event.is_action_pressed("ui_zoom_in"):
		HandleCameraZoom(-ZOOM_SENSITIVITY)
		
	if event.is_action_pressed("ui_zoom_out"):
		HandleCameraZoom(ZOOM_SENSITIVITY)
	
	if event.is_action_pressed("ui_right_click"):
		is_dragging = true
	elif event.is_action_released("ui_right_click"):
		is_dragging = false


# Custom functions

func UpdateCameraAngles(movement: Vector2):
	y_angle = clamp(y_angle + movement.y * delta * MOVE_SENSITIVITY, MIN_Y_ANGLE, MAX_Y_ANGLE)
	x_angle += movement.x * delta * MOVE_SENSITIVITY

func HandleCameraZoom(dist_offset: float):
	target_dist = clamp(target_dist + dist_offset, MIN_DIST, MAX_DIST)
	tween.interpolate_property(
		self,
		"dist",
		dist,
		target_dist,
		ZOOM_DURATION,
		tween.TRANS_SINE,
		tween.EASE_OUT
	)
	tween.start()

func HandleCameraMovement():
	var y = dist * sin(y_angle)
	var plane_dist = dist * cos(y_angle)
	
	var x = plane_dist * cos(x_angle)
	var z = plane_dist * sin(x_angle)
	
	self.transform.origin = Vector3(x, y, z)
	self.look_at(rig.transform.origin, Vector3.UP)
