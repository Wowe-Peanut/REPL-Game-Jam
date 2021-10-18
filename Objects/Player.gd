extends KinematicBody2D

#Movement
var speed = 300
var grav = 4000
var jump = -1000
var velocity: Vector2

#Water
var water = 500
var min_water = 100

func get_input():
	#Movement
	velocity.x = 0
	if Input.is_action_pressed("left"):
		velocity.x -= speed
	if Input.is_action_pressed("right"):
		velocity.x += speed
		
	#Water
	if Input.is_action_pressed("squirt"):
		water -= 1
		water = min_water if water < min_water else water

func _process(delta):
	#Movement
	get_input()
	velocity.y += grav * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
			if is_on_floor():
				velocity.y = jump
				
	#Water Shrinking
	scale = Vector2(water/100.0, water/100.0)







