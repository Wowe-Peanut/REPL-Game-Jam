extends Area2D

var water = 0
var max_water = 100
var player

func _ready():
	update_water_level()

func update_water_level():
	$WaterLevel.rect_size.y = water if water < max_water else max_water

func _on_WaterContainer_body_entered(body):
	if "WaterParticle" in body.name:
		if water < max_water:
			body.queue_free()
			water += body.amount
		
		
		update_water_level()
	elif "Player" in body.name:
		$DrainTimer.start()
		player = body

func _on_DrainTimer_timeout():
	if water > 0:
		player.water += 1
		water -= 1
		update_water_level()
	


func _on_WaterContainer_body_exited(body):
	if body.name == "Player":
		$DrainTimer.stop()

