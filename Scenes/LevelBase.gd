extends Node2D

export var starting_water = 100
export var water_required = 50
var dialogue = Dialogic.start("say")

func say(speaker, text):
	Dialogic.set_variable("speaker", speaker)
	Dialogic.set_variable("next_line", text)
	add_child(dialogue)

