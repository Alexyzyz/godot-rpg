extends Node

onready var camera = $Cam
onready var tween = $Tween

const SPEED = 50

var position: Vector3
var target_position: Vector3

var delta: float

func _process(process_delta):
	delta = process_delta
	
	HandleRigMovement()

# Custom functions

func HandleRigMovement():
	var x_axis = int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A))
	var z_axis = int(Input.is_key_pressed(KEY_W)) - int(Input.is_key_pressed(KEY_S))
	
	# rotation weirdness happening here, don't ask why
	# i had to make x_axis negative for some reason
	var direction = Vector3(-x_axis, 0, z_axis).normalized()
	direction = direction.rotated(Vector3.DOWN, camera.x_angle + PI / 2)
	
	target_position += SPEED * direction * delta
	tween.interpolate_property(
		self,
		"position",
		position,
		target_position,
		0.5,
		tween.TRANS_SINE,
		tween.EASE_OUT
	)
	tween.start()
	
	self.transform.origin = position
