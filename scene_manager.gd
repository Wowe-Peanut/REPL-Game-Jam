extends Node

var level = 1

func next_level():
	level += 1
	get_tree().change_scene("res://Scenes/Level"+str(level)+".tscn")
	print("Loading level: " + str(level))
