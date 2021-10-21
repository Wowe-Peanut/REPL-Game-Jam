extends Area2D

func _on_Dixie_body_entered(body):
	if body.name == "Player":
		SceneManager.next_level()
