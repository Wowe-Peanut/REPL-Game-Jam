extends Node2D

onready var main_menu = $MainMenu
var current_level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func load_first_level():
	print("Loading Level: 1")
	# Disable menu
	main_menu.visible = false
	# Load and instance first level, then add it as a child of Main
	add_child(load("res://Scenes/Level1.tscn").instance())
	current_level = 1

func next_level():
	print("Loading Level: " + str(current_level+1))
	# Delete current level node
	get_node("Level"+str(current_level)).queue_free()
	
	current_level += 1
	# Load and instance new level, then add it as a child of Main
	add_child(load("res://Scenes/Level"+str(current_level)+".tscn").instance())
