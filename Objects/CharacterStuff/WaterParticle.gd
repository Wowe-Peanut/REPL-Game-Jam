extends RigidBody2D

var amount:float = 0

func _on_WaterParticle_body_entered(body):
	queue_free()
