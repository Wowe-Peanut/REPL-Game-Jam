extends Area2D

func _on_Area2D_body_exited(body):
	if "WaterParticle" in body.name:
		body.queue_free()
	elif "Player" in body.name:
		get_tree().get_root().get_node("Main").restart_level()
