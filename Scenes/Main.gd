extends Node2D

onready var main_menu = $MainMenu
onready var control_menu = $Controls
var current_level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	hide_controls()

func load_first_level():
	print("Loading Level: 1")
	# Disable menu
	main_menu.visible = false
	# Load and instance first level, then add it as a child of Main
	add_child(load("res://Scenes/Level1.tscn").instance(), true)
	current_level = 1

func restart_level():
	print("Reloading Level: " + str(current_level))
	var level_scene = get_node("Level"+str(current_level))
	remove_child(level_scene)
	level_scene.queue_free()
	add_child(load("res://Scenes/Level"+str(current_level)+".tscn").instance(), true)

func next_level():
	print("Loading Level: " + str(current_level+1))
	# Delete current level node
	get_node("Level"+str(current_level)).queue_free()
	current_level += 1
	# Load and instance new level, then add it as a child of Main
	add_child(load("res://Scenes/Level"+str(current_level)+".tscn").instance(), true)

func show_controls():
	for child in control_menu.get_children():
		child.show()

func hide_controls():
	for child in control_menu.get_children():
		child.hide()

func start_tutorial():
	main_menu.visible = false
	add_child(load("res://Scenes/HowToPlay.tscn").instance())

func end_tutorial():
	get_node("HowToPlay").queue_free()
	main_menu.visible = true
