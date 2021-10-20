extends Area2D

var water = 0
var max_water = 100

func _ready():
	update_water_level()

func update_water_level():
	$WaterLevel.rect_size.y = water if water < max_water else max_water
	



func _on_WaterContainer_body_entered(body):
	body.queue_free()
	water += 1
	update_water_level()
