extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_PlayButton_pressed():
	# Load the first level
	get_tree().get_root().get_node("Main").load_first_level()

func _on_QuitButton_pressed():
	get_tree().quit()