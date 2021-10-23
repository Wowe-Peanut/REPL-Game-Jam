extends Control

var current_page = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_NextButton_pressed():
	if current_page != 4:
		print("Loading Page: " + str(current_page+1))
		get_node("Page" + str(current_page)).queue_free()
		current_page += 1
		add_child(load("res://Scenes/Tutorial/Page" + str(current_page) + ".tscn").instance())

	else:
		get_tree().get_root().get_node("Main").end_tutorial()
