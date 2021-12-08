extends "res://Scenes/LevelBase.gd"


func _ready():
	if get_tree().get_root().get_node("Main").resets == 0:
		var intro_1 = Dialogic.start("1_intro")
		intro_1.connect("dialogic_signal", self, "dialog_listener")
		intro_1.pause_mode = PAUSE_MODE_PROCESS
		add_child(intro_1)
		get_tree().paused = true
	
func _process(delta):
	if get_tree().get_root().get_node("Main").resets == 10:
		say("Dixie", "You have had to reset 10 times on the first level... wtf")
	
func dialog_listener(argument):
	match argument:
		"start_movement":
			get_tree().paused = false
