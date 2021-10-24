extends Area2D

var water:float = 0
var max_water = 100
var player

func _ready():
	update_water_level()

func update_water_level():
	$WaterLevel.rect_size.y = 150*(water/max_water) if water < max_water else 150
	if water > 0:
		$LowWaterLevel.show()
	else:
		$LowWaterLevel.hide()

	

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
	if body.name == "Player" or body.name == "TutorialPlayer":
		$DrainTimer.stop()

