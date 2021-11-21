extends Spatial

func _ready():
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size / 2 - window_size / 2)

func _process(_process_delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
