extends Node2D

onready var main_menu = $MainMenu
onready var control_menu = $Controls
onready var resetCounter = $CanvasLayer/ResetCounter
var current_level = 1
var resets = 0

var muted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	resetCounter.visible = false


func load_first_level():
	resetCounter.visible = true
	# Disable menu
	main_menu.visible = false
	# Load and instance first level, then add it as a child of Main
	add_child(load("res://Scenes/Level1.tscn").instance(), true)
	current_level = 1
	if not muted:
		$GameMusic.play()

func restart_level():
	# Update Reset Counter
	resets += 1
	resetCounter.text = "RESETS: " + str(resets)
	# Delete previous level node
	var level_scene = get_node("Level"+str(current_level))
	level_scene.name = "old"
	level_scene.queue_free()
	# Add new instance as a child of main node
	call_deferred("add_child", load("res://Scenes/Level"+str(current_level)+".tscn").instance(), true)

func next_level():
	# Delete current level node
	var level_scene = get_node("Level"+str(current_level))
	level_scene.name = "old"
	level_scene.queue_free()
	current_level += 1
	# Load and instance new level, then add it as a child of Main
	call_deferred("add_child", load("res://Scenes/Level"+str(current_level)+".tscn").instance(), true)


func start_tutorial():
	main_menu.visible = false
	add_child(load("res://Scenes/HowToPlay.tscn").instance())

func end_tutorial():
	get_node("HowToPlay").queue_free()
	main_menu.visible = true
