extends Control

onready var credits = $CreditsPopup
onready var title_art = $TitleArt

var rotation_timer = 0
var original_title_size

# Called when the node enters the scene tree for the first time.
func _ready():
	original_title_size = title_art.rect_scale
	
func _process(delta):
	title_art.set_rotation(sin(rotation_timer) * .15)
	rotation_timer += delta
	title_art.rect_scale = original_title_size * cos(rotation_timer / 2) * .1 + original_title_size

func _on_PlayButton_pressed():
	# Load the first level
	get_tree().get_root().get_node("Main").load_first_level()
	$MainMenuMusic.stop()

func _on_QuitButton_pressed():
	get_tree().quit()


func _on_Credits_pressed():
	credits.popup()


func _on_Close_pressed():
	credits.hide()


func _on_HowToPlayButton_pressed():
	get_tree().get_root().get_node("Main").start_tutorial()
