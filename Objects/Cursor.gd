extends Node2D

var distance

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	global_position = get_global_mouse_position()
	
