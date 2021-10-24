extends Node2D

var distance

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass

#func _process(delta):
	#global_position = get_global_mouse_position()
	#global_position = get_viewport().get_mouse_position()

func get_pos():
	#return global_position
	return get_viewport().get_mouse_position()

func get_power():
	return position.length()
