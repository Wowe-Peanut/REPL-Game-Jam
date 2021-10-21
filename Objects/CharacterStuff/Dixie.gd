extends Area2D

func _on_Dixie_body_entered(body):
	if body.name == "Player":
		get_tree().get_root().get_node("Main").next_level()
